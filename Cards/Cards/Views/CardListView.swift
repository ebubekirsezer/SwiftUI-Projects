//
//  CardListView.swift
//  Cards
//
//  Created by Ebubekir Sezer on 4.11.2021.
//

import SwiftUI

struct CardListView: View {
    
    @EnvironmentObject var viewState: ViewState
    @EnvironmentObject var store: CardStore
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(store.cards) { card in
                    CardThumbnailView(card: card)
                        .contextMenu(menuItems: {
                            Button {
                                store.remove(card)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }

                        })
                        .onTapGesture {
                            viewState.selectedCard = card
                            viewState.showAllCards.toggle()
                        }
                }
            }
        }
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView()
            .environmentObject(ViewState())
            .environmentObject(CardStore(defaultData: true))
    }
}
