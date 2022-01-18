//
//  MenuListViewModelTests.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 16.01.2022.
//

import XCTest
@testable import Albertos
import Combine

class MenuListViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testCallsGivenGroupingFunction() throws {
        try XCTSkipIf(true, "skipping this for now, keeping it to reuse part of the code later on")
        var called = false
        let inputSections = [MenuSection.fixture()]
        let spyClosure: ([MenuItem]) -> [MenuSection] = { items in
            called = true
            return inputSections
        }
        
        let viewModel = MenuList.ViewModel(menuFetching: MenuFetchingPlaceholder(), menuGrouping: spyClosure)
        let sections = try viewModel.sections.get()
        
        XCTAssertTrue(called)
        XCTAssertEqual(sections, inputSections)
    }
    
    func testWhenFetchingStartsPublishesEmptyMenu() throws {
        let viewModel = MenuList.ViewModel(menuFetching: MenuFetchingStub(returning: .success([.fixture()])))
        let sections = try viewModel.sections.get()
        XCTAssertTrue(sections.isEmpty)
    }
    
    func testWhenFetchingSucceedsPublishesSectionsBuiltFromReceivedMenuAndGivenGroupingClosure() {
        // Arrange the ViewModel and its data source
        // Act on the ViewModel to trigger update
        // Assert the expected behavior
        var receivedMenu: [MenuItem]?
        let expectedSections = [MenuSection.fixture()]
        let spyClosure: ([MenuItem]) -> [MenuSection] = { items in
            receivedMenu = items
            return expectedSections
        }
        let expectedMenu = [MenuItem.fixture()]
        let menuFetchingStub = MenuFetchingStub(returning: .success(expectedMenu))
        let viewModel = MenuList.ViewModel(menuFetching: menuFetchingStub, menuGrouping: spyClosure)
        let expectation = XCTestExpectation(description: "Publishes sections built from received menu and given grouping closure")
        viewModel.$sections
            .dropFirst()
            .sink { value in
                
                guard case .success(let sections) = value else {
                    return XCTFail("Expected a successful Result, got: \(value)")
                }
                
                // Ensure the grouping closure is called with the received menu
                XCTAssertEqual(receivedMenu, expectedMenu)
                // Ensure the published value is the result of the grouping closure
                XCTAssertEqual(sections, expectedSections)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWhenFetchingFailsPublishesAnError() {
        let expectedError = TestError(id: 123)
        let menuFetchingStub = MenuFetchingStub(returning: .failure(expectedError))
        let viewModel = MenuList.ViewModel(menuFetching: menuFetchingStub) { _ in
            []
        }
        let expectation = XCTestExpectation(description: "Publishes an Error")
        viewModel.$sections
            .dropFirst()
            .sink { value in
                guard case .failure(let error) = value else {
                    return XCTFail("Expected a failing Result, got: \(value)")
                }
                XCTAssertEqual(error as? TestError, expectedError)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    

}
