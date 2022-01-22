//
//  Order.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 22.01.2022.
//

import Foundation

struct Order {
    let items: [MenuItem]
    var total: Double {
        items.reduce(0, { $0 + $1.price })
    }
}
