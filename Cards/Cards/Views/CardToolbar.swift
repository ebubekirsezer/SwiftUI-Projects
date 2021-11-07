//
//  CardToolbar.swift
//  Cards
//
//  Created by Ebubekir Sezer on 4.11.2021.
//

import SwiftUI

struct CardToolbar: ViewModifier {
    
    @EnvironmentObject var viewState: ViewState
    @Binding var currentModal: CardModal?
    
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewState.showAllCards.toggle()
                    } label: {
                        Text("Done")
                    }
                    
                }
                
                ToolbarItem(placement: .bottomBar) {
                    CardBottomToolbar(cardModal: $currentModal)
                }
            }
    }
}
