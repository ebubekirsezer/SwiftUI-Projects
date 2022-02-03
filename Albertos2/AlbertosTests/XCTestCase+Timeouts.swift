//
//  XCTestCase+Timeouts.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 31.01.2022.
//

import Foundation
import XCTest

extension XCTestCase {
    /// Using  a wait time of around 1 second seems to result in
    /// occasional  test timeout failures when using
    /// 'XCTNSPredicateExpectations'
    var timeoutForPredicateExpectations: Double { 2.0 }
}
