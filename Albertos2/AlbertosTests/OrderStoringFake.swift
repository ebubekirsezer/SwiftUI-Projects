//
//  OrderStoringFake.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 10.02.2022.
//

import Foundation
@testable import Albertos

class OrderStoringFake: OrderStoring {
    private var order: Order = Order(items: [])
    
    func getOrder() -> Order {
        return order
    }
    
    func updateOrder(_ order: Order) {
        self.order = order
    }
}
