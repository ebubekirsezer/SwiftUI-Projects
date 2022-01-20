//
//  NetworkFetching.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 20.01.2022.
//

import Foundation
import Combine

protocol NetworkFetching {
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError>
}
