//
//  PaymentProcessingStub.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 31.01.2022.
//

import Foundation
import Combine
@testable import Albertos

class PaymentProcessingStub: PaymentProcessing {
    let result: Result<Void, Error>
    
    init(returning result: Result<Void, Error>) {
        self.result = result
    }
    
    func process(order: Order) -> AnyPublisher<Void, Error> {
        return result.publisher
            .delay(for: 0.01, scheduler: RunLoop.main) // Use a delay to simulate the real world async 
            .eraseToAnyPublisher()
    }
}
