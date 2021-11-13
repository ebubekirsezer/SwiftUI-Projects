//
//  CardsView.swift
//  Cards
//
//  Created by Ebubekir Sezer on 4.11.2021.
//

import SwiftUI

struct CardsView: View {
    
    @EnvironmentObject var viewState: ViewState
    @EnvironmentObject var store: CardStore
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    viewState.selectedCard = store.addCard()
                    viewState.showAllCards = false
                } label: {
                    Text("Add")
                }
                
                CardListView()
            }
            
            if !viewState.showAllCards {
                SingleCardView()
                    .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
            .environmentObject(ViewState())
            .environmentObject(CardStore(defaultData: true))
    }
}
