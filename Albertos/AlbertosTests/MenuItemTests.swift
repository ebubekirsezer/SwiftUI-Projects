//
//  MenuItemTests.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 19.01.2022.
//

import XCTest
@testable import Albertos

class MenuItemTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testWhenDecodedFromJSONDataHasAllTheInputProperties() throws {
        // arrange the JSON Data Input
        
        
        // Option 1 For the creating json
//
        let json = #"{ "name": "a name", "category": "a category", "spicy": true, "price": 1.0 }"#
//        let data = try XCTUnwrap(json.data(using: .utf8))
        
        //let json = MenuItem.jsonFixture(name: "a name", category: "a category", spicy: true, price: 1.0)
//        let json = """
//        {
//            "name": "a name",
//            "category": {
//                "name": "a category",
//                "id": 123
//            },
//            "spicy": true,
//            "price": 1.0
//        }
//        """
        let data = try XCTUnwrap(json.data(using: .utf8))
        
        // Option 2 For the creating json
        
//        let url = try XCTUnwrap(Bundle(for: type(of: self)).url(forResource: "menu_item", withExtension: "json"))
//        let data = try Data(contentsOf: url)
        
        //let data = try dataFromJSONFileNamed("menu_item")
        
        // act by decoding a MenuItem instance from the Data
        let item = try JSONDecoder().decode(MenuItem.self, from: data)
        // assert the MenuItem matches the input
        XCTAssertEqual(item.name, "a name")
        XCTAssertEqual(item.category, "a category")
        XCTAssertEqual(item.spicy, true)
        XCTAssertEqual(item.price, 1.0)
    }
    
    func testWhenDecodingFromJSONDataDoesNotThrow() throws {
        let json = #"{ "name": "a name", "category": "a category", "spicy": true, "price": 1.0 }"#
        let data = try XCTUnwrap(json.data(using: .utf8))
        XCTAssertNoThrow(try JSONDecoder().decode(MenuItem.self, from: data))
    }
}
