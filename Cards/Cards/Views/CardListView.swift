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
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack {
                    LazyVGrid(columns: columns(size: proxy.size), spacing: 30) {
                        ForEach(store.cards) { card in
                            CardThumbnailView(card: card, size: proxy.size)
                                .contextMenu(menuItems: {
                                    Button {
                                        store.remove(card)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }

                                })
                                .onTapGesture {
                                    viewState.selectedCard = card
                                    withAnimation {
                                        viewState.showAllCards = false
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
    
    func columns(size: CGSize) -> [GridItem] {
        [
            GridItem(.adaptive(
                minimum: Settings.thumbnailSize(size: size).width))
        ]
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView()
            .environmentObject(ViewState())
            .environmentObject(CardStore(defaultData: true))
    }
}
