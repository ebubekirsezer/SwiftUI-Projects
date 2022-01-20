//
//  NetworkFetchingStub.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 20.01.2022.
//

import Foundation
@testable import Albertos
import Combine

class NetworkFetchingStub: NetworkFetching {
    private let result: Result<Data, URLError>
    
    init(returning result: Result<Data, URLError>) {
        self.result = result
    }
    
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        // Use a delay to simulate the real world async behavior
        return result.publisher
            .delay(for: 0.01, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
