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
            
            CardListView()
            VStack {
                Spacer()
                createButton
            }
            
            if !viewState.showAllCards {
                SingleCardView()
                    .navigationViewStyle(StackNavigationViewStyle())
            }
        }
        .background(
            Color("background")
                .edgesIgnoringSafeArea(.all)
        )
    }
    
    var createButton: some View {
        Button {
            viewState.selectedCard = store.addCard()
            viewState.showAllCards = false
        } label: {
            Label("Create New", systemImage: "plus")
                .frame(maxWidth: .infinity)
        }
        .font(.system(size: 16, weight: .bold))
        .padding([.bottom, .top], 10)
        .background(Color("barColor"))
        .accentColor(.white)

    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
            .environmentObject(ViewState())
            .environmentObject(CardStore(defaultData: true))
    }
}
