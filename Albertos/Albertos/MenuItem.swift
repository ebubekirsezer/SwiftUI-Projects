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
    let spicy: Bool
    let price: Double
//    private let categoryObject: Category
//    var category: String { categoryObject.name }
//
//    enum CodingKeys: String, CodingKey {
//        case name, spicy, price
//        case categoryObject = "category"
//    }
//
//    struct Category: Equatable, Decodable {
//        let name: String
//    }
}

extension MenuItem: Identifiable {
    var id: String { name }
}

extension MenuItem: Equatable {
    
}

extension MenuItem: Decodable {
    
}

//extension MenuItem {
//    init(category: String, name: String, spicy: Bool, price: Double) {
//        self.categoryObject = Category(name: category)
//        self.name = name
//        self.spicy = spicy
//        self.price = price
//    }
//}
