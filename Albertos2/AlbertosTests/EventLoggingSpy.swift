//
//  EventLoggingSpy.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 29.01.2022.
//

@testable import Albertos

class EventLoggingSpy: EventLogging {
    
    private(set) var loggedEvents: [LoggedEvent] = []
    
    func log(name: String, properties: [String : Any]) {
        let loggedEvent = LoggedEvent(name: name, properties: properties)
        loggedEvents.append(loggedEvent)
    }
}

struct LoggedEvent {
    var name: String
    var properties: [String: Any]
}
