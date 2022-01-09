//
//  MacMarkDownApp.swift
//  MacMarkDown
//
//  Created by Ebubekir Sezer on 8.01.2022.
//

import SwiftUI

@main
struct MacMarkDownApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: MacMarkDownDocument()) { file in
            ContentView(document: file.$document)
        }
        .commands {
            MenuCommands()
        }
        
        Settings {
            SettingsView()
        }
    }
}
