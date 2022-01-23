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
    private let request: URLRequest?
    
    init(returning result: Result<Data, URLError>,
         for request: URLRequest? = .none) {
        self.result = result
        self.request = request
    }
    
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        
        let result: Result<Data, URLError>
        switch self.request {
        case .none: result = self.result
        case .some(let storedRequest) where storedRequest == request:
            result = self.result
        case _:
            result = .failure(URLError(.unknown))
        }
        
        // Use a delay to simulate the real world async behavior
        return result.publisher
            .delay(for: 0.01, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
