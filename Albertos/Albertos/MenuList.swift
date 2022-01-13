//
//  MenuList.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 13.01.2022.
//

import SwiftUI

struct MenuList: View {
    let sections: [MenuSection]
    
    var body: some View {
        List {
            ForEach(sections) { section in
                Section {
                    ForEach(section.items) { item in
                        Text(item.name)
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
        MenuList(sections: [])
    }
}
