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
                        withAnimation {
                            viewState.showAllCards = true
                        }
                    } label: {
                        Text("Done")
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewState.shouldScreenshot = true
                        currentModal = .shareSheet
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }

                }
                
                ToolbarItem(placement: .bottomBar) {
                    CardBottomToolbar(cardModal: $currentModal)
                }
            }
    }
}
