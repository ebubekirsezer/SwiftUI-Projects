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
        VStack {
            
            if viewState.showAllCards {
                ListSelectionView(selection: $viewState.cardListState)
            }
            
            ZStack {
                
                switch viewState.cardListState {
                case .list:
                    CardListView()
                case .carousel:
                    Carousel()
                }
                
                VStack {
                    Spacer()
                    createButton
                }
                
                if !viewState.showAllCards {
                    SingleCardView()
                        .transition(.move(edge: .bottom))
                        .zIndex(1)
                        .navigationViewStyle(StackNavigationViewStyle())
                }
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
            withAnimation {
                viewState.showAllCards = false
            } 
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
