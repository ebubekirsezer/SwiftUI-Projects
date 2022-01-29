//
//  PaymentProcessingSpy.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 29.01.2022.
//

import Combine
@testable import Albertos

class PaymentProcessingSpy: PaymentProcessing {

    private(set) var receivedOrder: Order?
    
    func process(order: Order) -> AnyPublisher<Void, Error> {
        receivedOrder = order
        return Result<Void, Error>.success(()).publisher.eraseToAnyPublisher()
    }
}
