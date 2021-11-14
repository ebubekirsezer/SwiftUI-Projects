//
//  TextPicker.swift
//  Cards
//
//  Created by Ebubekir Sezer on 13.11.2021.
//

import SwiftUI

struct TextPicker: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @Binding var textElement: TextElement
    
    var body: some View {
        let onCommit = {
            presentationMode.wrappedValue.dismiss()
        }
        VStack {
            TextField("Enter Text", text: $textElement.text, onCommit: onCommit)
                .font(.custom(textElement.textFont, size: 30))
                .foregroundColor(textElement.textColor)
            TextView(font: $textElement.textFont, color: $textElement.textColor)
        }
    }
}

struct TextPicker_Previews: PreviewProvider {
    @State static var textElement = TextElement()
    static var previews: some View {
        TextPicker(textElement: $textElement)
    }
}
