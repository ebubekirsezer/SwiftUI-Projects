//
//  MenuSection+Fixture.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 16.01.2022.
//

@testable import Albertos

extension MenuSection {
    static func fixture(category: String = "a category",
                        items: [MenuItem] = [.fixture()]) -> MenuSection {
        return MenuSection(category: category, items: items)
    }
}
