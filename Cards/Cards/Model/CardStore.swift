//
//  CardStore.swift
//  Cards
//
//  Created by Ebubekir Sezer on 5.11.2021.
//

import SwiftUI

class CardStore: ObservableObject {
    @Published var cards: [Card] = []
    
    init(defaultData: Bool = false) {
        if defaultData {
            cards = initialCards
        }
    }
    
    func index(for card: Card) -> Int? {
        cards.firstIndex(where: { $0.id == card.id })
    }
    
    func remove(_ element: Card) {
        if let index = index(for: element) {
            cards.remove(at: index)
        }
    }
}
