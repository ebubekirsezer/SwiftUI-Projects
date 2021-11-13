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
        cards = defaultData ? initialCards : load()
    }
    
    func index(for card: Card) -> Int? {
        cards.firstIndex(where: { $0.id == card.id })
    }
    
    func remove(_ element: Card) {
        if let index = index(for: element) {
            cards.remove(at: index)
        }
    }
    
    func addCard() -> Card {
        let card = Card(backgroundColor: Color.random())
        cards.append(card)
        card.save()
        return card
    }
}

extension CardStore {
    
    func load() -> [Card] {
        var cards: [Card] = []
        
        guard let path = FileManager.documentURL?.path,
              let enumarator = FileManager.default.enumerator(atPath: path),
              let files = enumarator.allObjects as? [String] else { return cards }
        
        let cardFiles = files.filter({ $0.contains(".rwcard")})
        for cardFile in cardFiles {
            do {
                
                let path = path + "/" + cardFile
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let card = try decoder.decode(Card.self, from: data)
                cards.append(card)
            } catch {
                print("Error: ", error.localizedDescription)
            }
        }
        
        return cards
    }
}
