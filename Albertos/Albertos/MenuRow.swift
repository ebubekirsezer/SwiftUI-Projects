//
//  MenuRow.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 16.01.2022.
//

import SwiftUI

struct MenuRow: View {
    let viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.text)
    }
}
