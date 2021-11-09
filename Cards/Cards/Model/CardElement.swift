//
//  CardElement.swift
//  Cards
//
//  Created by Ebubekir Sezer on 5.11.2021.
//

import SwiftUI

protocol CardElement {
    var id: UUID { get }
    var transform: Transform { get set }
}

struct ImageElement: CardElement {
    let id: UUID = UUID()
    var transform: Transform = Transform()
    var image: Image
    var frame: AnyShape?
}

struct TextElement: CardElement {
    let id: UUID = UUID()
    var transform: Transform = Transform()
    var text = ""
    var textColor = Color.black
    var textFont = "San Fransisco"
}


extension CardElement {
    func index(in array: [CardElement]) -> Int? {
        array.firstIndex { $0.id == id }
    }
}
