//
//  MenuCommands.swift
//  MacMarkDown
//
//  Created by Ebubekir Sezer on 8.01.2022.
//

import SwiftUI

struct MenuCommands: Commands {
    
    @AppStorage("styleSheet") var styleSheet: StyleSheet = .raywenderlich
    
    var body: some Commands {
        CommandGroup(before: .help) {
            Button("Markdown Cheatsheet") {
                showCheatSheet()
            }
            .keyboardShortcut("/", modifiers: .command)
            
            Divider()
        }
        
        CommandMenu("Stylesheet") {
            ForEach(StyleSheet.allCases, id: \.self) { style in
                Button(style.rawValue) {
                    styleSheet = style
                }
                .keyboardShortcut(style.shortcutKey, modifiers: .command)
            }
        }
    }
    
    func showCheatSheet() {
        let cheatSheetAddress = "https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet"
        guard let url = URL(string: cheatSheetAddress) else {
            fatalError("Invalid cheatsheet URL")
        }
        
        NSWorkspace.shared.open(url)
    }
}
