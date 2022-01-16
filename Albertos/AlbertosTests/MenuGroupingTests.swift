//
//  MenuGroupingTests.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 13.01.2022.
//

import XCTest
@testable import Albertos

class MenuGroupingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Given a menu with many categories, returns as many
    ///  /// sections, in reverse alphabetical order
    func testMenuWithManyCategoriesReturnsAsManySectionsInReverseAlphabeticalOrder() {
        let menu = [
            MenuItem.fixture(category: "pastas"),
            MenuItem.fixture(category: "drinks"),
            MenuItem.fixture(category: "pastas"),
            MenuItem.fixture(category: "desserts")
        ]
        let sections = groupMenuByCategory(menu)
        XCTAssertEqual(sections.count, 3)
        
        XCTAssertEqual(sections[safe: 0]?.category, "pastas")
        XCTAssertEqual(sections[safe: 1]?.category, "drinks")
        XCTAssertEqual(sections[safe: 2]?.category, "desserts")
    }
    
    func testMenuWithOneCategoryReturnsOneSection() throws {
        let menu = [
            MenuItem.fixture(category: "pastas", name: "name"),
            MenuItem.fixture(category: "pastas", name: "other name")
        ]
        let sections = groupMenuByCategory(menu)
        
        XCTAssertEqual(sections.count, 1)
        let section = try XCTUnwrap(sections.first)
        XCTAssertEqual(section.items.count, 2)
        XCTAssertEqual(section.items.first?.name, "name")
        XCTAssertEqual(section.items.last?.name, "other name")
    }
    
    func testEmptyMenuReturnsEmptySections() {
        // Arrange the inputs: an empty menu
        // Act on the SUT to get the output: the sections array
        let menu = [MenuItem]()
        let sections = groupMenuByCategory(menu)
        XCTAssertTrue(sections.isEmpty)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
