//
//  MenuFetching.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 16.01.2022.
//

import Combine

protocol MenuFetching {
    func fetchMenu() -> AnyPublisher<[MenuItem], Error>
}
