//
//  MenuList+ViewModel.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 16.01.2022.
//

import Combine

extension MenuList {
    
    class ViewModel: ObservableObject {
        @Published private(set) var sections: [MenuSection]
        
        private var cancellables = Set<AnyCancellable>()
        
        init(menuFetching: MenuFetching,
             menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory) {
            sections = []
            menuFetching
                .fetchMenu()
                .sink { _ in
                    
                } receiveValue: { [weak self] value in
                    self?.sections = menuGrouping(value)
                }
                .store(in: &cancellables)

        }
    }
}
