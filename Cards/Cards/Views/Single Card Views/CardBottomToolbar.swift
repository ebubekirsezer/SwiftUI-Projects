//
//  CardBottomToolbar.swift
//  Cards
//
//  Created by Ebubekir Sezer on 4.11.2021.
//

import SwiftUI

struct ToolbarBottomView: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    let modal: CardModal
    
    private let modalButton: [CardModal: (text: String, imageName: String)] = [
        .photoPicker: ("Photos", "photo"),
        .framePicker: ("Frames", "square.on.circle"),
        .stickerPicker: ("Stickers", "heart.circle"),
        .textPicker: ("Text", "textformat")
    ]
    
    var body: some View {
        
        if let text = modalButton[modal]?.text,
           let imageName = modalButton[modal]?.imageName {
            
            if verticalSizeClass == .compact {
                compactView(imageName)
            } else {
                regularView(imageName, text)
            }
        }
    }
    
    func regularView(_ imageName: String, _ text: String) -> some View {
        VStack(spacing: 2) {
            Image(systemName: imageName)
            Text(text)
        }
        .frame(minWidth: 60)
        .padding(.top, 5)
    }
    
    func compactView(_ imageName: String) -> some View {
        VStack(spacing: 2) {
            Image(systemName: imageName)
        }
        .frame(minWidth: 60)
        .padding(.top, 5)
        
    }
}

struct CardBottomToolbar: View {
    
    @Binding var cardModal: CardModal?
    
    var body: some View {
        HStack(alignment: .bottom) {
            
            Button {
                cardModal = .photoPicker
            } label: {
                ToolbarBottomView(modal: .photoPicker)
            }
            
            Button {
                cardModal = .framePicker
            } label: {
                ToolbarBottomView(modal: .framePicker)
            }
            
            Button {
                cardModal = .stickerPicker
            } label: {
                ToolbarBottomView(modal: .stickerPicker)
            }
            
            Button {
                cardModal = .textPicker
            } label: {
                ToolbarBottomView(modal: .textPicker)
            }

        }
    }
}

struct CardBottomToolbar_Previews: PreviewProvider {
    static var previews: some View {
        CardBottomToolbar(cardModal: .constant(.stickerPicker))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
