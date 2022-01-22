//
//  MenuItemDetail+ViewModel.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 22.01.2022.
//

import Foundation
import Combine

extension MenuItemDetail {
    
    class ViewModel: ObservableObject {
        let name: String
        let spicy: String?
        let price: String
        
        @Published private(set) var addOrRemoveFromOrderButtonText = "Remove from order"
        private let orderController: OrderController
        private let item: MenuItem
        private var cancellables = Set<AnyCancellable>()
        
        init(item: MenuItem,
             orderController: OrderController) {
            self.item = item
            self.orderController = orderController
            name = item.name
            spicy = item.spicy ? "Spicy" : .none
            price = "$\(String(format: "%.2f", item.price))"
            
            self.orderController.$order
                .sink { [weak self] order in
                    guard let self = self else { return }
                    if order.items.contains(where: { $0 == self.item }) {
                        self.addOrRemoveFromOrderButtonText = "Remove from order"
                    } else {
                        self.addOrRemoveFromOrderButtonText = "Add to order"
                    }
                }
                .store(in: &cancellables)
        }
        
        func addOrRemoveFromOrder() {
            if (orderController.order.items.contains(where: { $0 == item })) {
                orderController.removeFromOrder(item: item)
            } else {
                orderController.addToOrder(item: item)
            }
        }
    }
}
