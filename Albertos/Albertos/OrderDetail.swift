//
//  OrderDetail.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 22.01.2022.
//

import SwiftUI

struct OrderDetail: View {
    
    let viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.text)
    }
}
