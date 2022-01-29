//
//  PaymentProcessing.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 24.01.2022.
//

import Foundation
import Combine

protocol PaymentProcessing {
    func process(order: Order) -> AnyPublisher<Void, Error>
}
