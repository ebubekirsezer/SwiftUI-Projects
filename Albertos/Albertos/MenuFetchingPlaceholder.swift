//
//  MenuFetchingPlaceholder.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 16.01.2022.
//

import Foundation
import Combine

class MenuFetchingPlaceholder: MenuFetching {
    
    func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
        return Future {
            $0(.success(menu))
        }
        .delay(for: 0.5, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
