//
//  MenuRow+ViewModel.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 16.01.2022.
//

extension MenuRow {
    
    struct ViewModel {
        let text: String
        
        init(item: MenuItem) {
            text = item.spicy ? "\(item.name)🌶" : item.name
        }
    }
}
