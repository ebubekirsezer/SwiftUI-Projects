//
//  MenuItem.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 13.01.2022.
//

import Foundation

struct MenuItem {
    let category: String
    let name: String
}

extension MenuItem: Identifiable {
    var id: String { name }
}
