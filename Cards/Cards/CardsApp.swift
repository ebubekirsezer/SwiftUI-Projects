//
//  CardsApp.swift
//  Cards
//
//  Created by Ebubekir Sezer on 4.11.2021.
//

import SwiftUI

@main
struct CardsApp: App {
    
    @StateObject var viewState = ViewState()
    @StateObject var store = CardStore(defaultData: true)
    
    var body: some Scene {
        WindowGroup {
            CardsView()
                .environmentObject(viewState)
                .environmentObject(store)
                .onAppear {
                    print(FileManager.documentURL ?? "")
                }
        }
    }
}

struct Team: Codable {
    let names: [String]
    let count: Int
    
    static func save() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(teamData)
            
            if let url = FileManager.documentURL?.appendingPathComponent("TeamData") {
                try data.write(to: url)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func load() {
        
        if let url = FileManager.documentURL?.appendingPathComponent("TeamData") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let team = try decoder.decode(Team.self, from: data)
                print(team)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

let teamData = Team(names: ["Libranner", "Caroline", "Audrey","Manda"], count: 5)
