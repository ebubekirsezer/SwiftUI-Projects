//
//  MenuList.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 13.01.2022.
//

import SwiftUI

struct MenuList: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject private var orderController: OrderController
    
    var body: some View {
        
        switch viewModel.sections {
        case .success(let sections):
            List {
                ForEach(sections) { section in
                    Section(content: {
                        ForEach(section.items) { item in
                            NavigationLink(destination: destination(for: item)) {
                                MenuRow(viewModel: .init(item: item))
                            }
                        }
                    }, header: {
                        Text(section.category)
                    })
                }
            }
        case .failure(let error):
            Text("An error occurred:")
            Text(error.localizedDescription).italic()
        }
        
        
    }
    
    func destination(for item: MenuItem) -> MenuItemDetail {
        return MenuItemDetail(viewModel: .init(item: item, orderController: orderController))
    }
}
//
//struct MenuList_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuList(viewModel: .init(menuFetching: MenuFetchingPlaceholder()))
//    }
//}
