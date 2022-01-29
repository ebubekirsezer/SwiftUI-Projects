//
//  Order+Fixture.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 29.01.2022.
//

@testable import Albertos

extension Order {
    static func fixture(items: [MenuItem] = [.fixture()]) -> Order {
        return Order(items: items)
    }
}
