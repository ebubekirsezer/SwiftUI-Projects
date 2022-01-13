//
//  MenuSection.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 13.01.2022.
//

import Foundation

struct MenuSection {
    let category: String
    let items: [MenuItem]
}

extension MenuSection: Identifiable {
    var id: String { category }
}
