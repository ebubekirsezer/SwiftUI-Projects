//
//  UserDefaults+OrderStoring.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 10.02.2022.
//

import Foundation

fileprivate var orderKey = "order"

extension UserDefaults: OrderStoring {
    func getOrder() -> Order {
        guard let data = data(forKey: orderKey),
              let order = try? JSONDecoder().decode(Order.self, from: data) else {
                  let order = Order(items: [])
                  updateOrder(order)
                  return order
              }
        return order
    }
    
    func updateOrder(_ order: Order) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(order) else { return }
        setValue(data, forKey: orderKey)
    }
}
