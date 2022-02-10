//
//  PaymentProcessingDummy.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 10.02.2022.
//

import Foundation
import Combine
@testable import Albertos

class PaymentProcessingDummy: PaymentProcessing {
    func process(order: Order) -> AnyPublisher<Void, Error> {
        return Result<Void, Error>.success(())
            .publisher
            .eraseToAnyPublisher()
    }
}
