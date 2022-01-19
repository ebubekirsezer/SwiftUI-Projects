//
//  MenuItem+JSONFixture.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 19.01.2022.
//

import Foundation
@testable import Albertos

extension MenuItem {
    static func jsonFixture(name: String = "a name",
                            category: String = "a category",
                            spicy: Bool = true,
                            price: Double = 1.0) -> String {
        return """
{
    "name": \(name),
    "category": \(category),
    "spicy": \(spicy),
    "price": \(price)
}
"""
    }
}
