//
//  OrderButton.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 22.01.2022.
//

import SwiftUI

struct OrderButton: View {
    
    let viewModel: ViewModel
    
    @State private(set) var showingDetail: Bool = false
    
    var body: some View {
        Button {
            self.showingDetail.toggle()
        } label: {
            Text(viewModel.text)
                .font(Font.callout.bold())
                .padding(12)
                .foregroundColor(.white)
                .background(Color.crimson)
                .cornerRadius(10)
        }
        .sheet(isPresented: $showingDetail) {
            
        } content: {
            OrderDetail(viewModel: .init())
        }


    }
}
