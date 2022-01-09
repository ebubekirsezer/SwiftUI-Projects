//
//  MountainAirpotMacApp.swift
//  MountainAirpotMac
//
//  Created by Ebubekir Sezer on 9.01.2022.
//

import SwiftUI

@main
struct MountainAirpotMacApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            SidebarCommands()
        }
    }
}

enum DisplayState: Int {
    case none
    case flightBoard
    case searchFlights
    case awards
    case timeline
    case lastFlight
}
