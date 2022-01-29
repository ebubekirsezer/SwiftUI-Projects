//
//  HippoPaymentProcessor+PaymentProcessing.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 24.01.2022.
//

import Combine
import HippoPayments

extension HippoPaymentsProcessor: PaymentProcessing {
    func process(order: Order) -> AnyPublisher<Void, Error> {
        return Future { promise in
            self.processPayment(payload: order.hippoPaymentsPayload,
                                onSuccess: {
                promise(.success(()))
            }, onFailure: {
                promise(.failure($0))
            })
        }
        .eraseToAnyPublisher()
    }
}
