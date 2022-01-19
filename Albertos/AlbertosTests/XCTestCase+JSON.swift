//
//  XCTestCase+JSON.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 19.01.2022.
//

import Foundation
import XCTest

extension XCTestCase {
    func dataFromJSONFileNamed(_ name: String) throws -> Data {
        let url = try XCTUnwrap(Bundle(for: type(of: self)).url(forResource: name, withExtension: "json"))
        return try Data(contentsOf: url)
    }
}
