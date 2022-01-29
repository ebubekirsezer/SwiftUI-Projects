//
//  HippoAnalyticsClientInterfaceSpy.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 29.01.2022.
//

import Foundation
@testable import Albertos

class HippoAnalyticsClientInterfaceSpy: HippoAnalyticsClientInterface {
    
    struct Event {
        let name: String
        let properties: [String: Any]?
    }
    
    private(set) var loggedEvents: [Event] = []
    
    func logEvent(named name: String, properties: [String : Any]) {
        loggedEvents.append(Event(name: name, properties: properties))
    }
}
