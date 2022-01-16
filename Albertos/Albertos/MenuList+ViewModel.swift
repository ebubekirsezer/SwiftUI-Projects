//
//  MenuList+ViewModel.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 16.01.2022.
//

extension MenuList {
    
    struct ViewModel {
        let sections: [MenuSection]
        
        init(menu: [MenuItem],
             menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory) {
            self.sections = menuGrouping(menu)
        }
    }
}
