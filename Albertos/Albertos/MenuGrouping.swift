//
//  MenuGrouping.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 13.01.2022.
//

func groupMenuByCategory(_ menu: [MenuItem]) -> [MenuSection] {
    return Dictionary(grouping: menu) {
        $0.category
    }.map { (key, value) in
        MenuSection(category: key, items: value)
    }.sorted(by: { $0.category > $1.category })
}
