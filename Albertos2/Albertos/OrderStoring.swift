//
//  OrderStoring.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 10.02.2022.
//

import Foundation

protocol OrderStoring {
    func getOrder() -> Order
    func updateOrder(_ order: Order)
}
