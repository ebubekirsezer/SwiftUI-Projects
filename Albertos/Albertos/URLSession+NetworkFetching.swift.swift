//
//  URLSession+NetworkFetching.swift.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 20.01.2022.
//

import Foundation
import Combine

extension URLSession: NetworkFetching {
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return dataTaskPublisher(for: request)
            .map({ $0.data })
            .eraseToAnyPublisher()
    }
}
