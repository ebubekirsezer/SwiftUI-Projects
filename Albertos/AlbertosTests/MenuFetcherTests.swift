//
//  MenuFetcherTests.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 20.01.2022.
//

import XCTest
import Combine
@testable import Albertos

class MenuFetcherTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testWhenRequestSucceedsPublishesDecodedMenuItems() throws {
        let json = """
[
    { "name": "a name", "category": "a category", "spicy": true, "price": 1.0 },
    { "name": "another name", "category": "a category", "spicy": true, "price": 2.0 }
]
"""
        let data = try XCTUnwrap(json.data(using: .utf8))
        let menuFetcher = MenuFetcher(networkFetching: NetworkFetchingStub(returning: .success(data)))
        let expectation = XCTestExpectation(description: "Publishes decoded [MenuItem]")
        menuFetcher.fetchMenu()
            .sink { _ in
                
            } receiveValue: { items in
                // How to test if the value of items is correct?
                XCTAssertEqual(items.count, 2)
                XCTAssertEqual(items.first?.name, "a name")
                XCTAssertEqual(items.last?.name, "another name")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)

    }
    
    func testWhenRequestFailsPublishesReceivedError() {
        let expectedError = URLError(.badServerResponse)
        let menuFetcher = MenuFetcher(networkFetching: NetworkFetchingStub(returning: .failure(expectedError)))
        let expectation = XCTestExpectation(description: "Publishes received URLError")
        menuFetcher.fetchMenu()
            .sink { completion in
                guard case .failure(let error) = completion else { return }
                XCTAssertEqual(error as? URLError, expectedError)
                expectation.fulfill()
            } receiveValue: { items in
                XCTFail("Expected to fail, succeeded with \(items)")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)

    }
    
    func testUsesGivenBaseURLInRequest() throws {
        //let url = try XCTUnwrap(URL(string: "https://s3.amazonaws.com/mokacoding/menu_response.json"))
        let baseURL = try XCTUnwrap(URL(string: "https://test.url"))
        let url = baseURL.appendingPathComponent("menu_response.json")
        let json = """
[
    { "name": "a name", "category": "a category", "spicy": true, "price": 1.0 }
]
"""
        let data = try XCTUnwrap(json.data(using: .utf8))
        let networkingFetchingStub = NetworkFetchingStub(returning: .success(data), for: URLRequest(url: url))
        let menuFetcher = MenuFetcher(baseURL: baseURL, networkFetching: networkingFetchingStub)

        let expectation = XCTestExpectation(description: "Receives data")
        
        menuFetcher.fetchMenu()
            .sink { _ in
                
            } receiveValue: { items in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}
