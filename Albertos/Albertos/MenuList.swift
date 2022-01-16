//
//  MenuList.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 13.01.2022.
//

import SwiftUI

struct MenuList: View {
    let viewModel: ViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.sections) { section in
                Section {
                    ForEach(section.items) { item in
                        MenuRow(viewModel: .init(item: item))
                    }
                } header: {
                    Text(section.category)
                }

            }
        }
    }
}

struct MenuList_Previews: PreviewProvider {
    static var previews: some View {
        MenuList(viewModel: .init(menu: []))
    }
}
