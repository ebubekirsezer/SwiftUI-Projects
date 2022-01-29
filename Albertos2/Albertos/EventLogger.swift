//
//  EventLogger.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 29.01.2022.
//

import Foundation

class EventLogger: EventLogging {
    
    private let hippoAnalyticsClient: HippoAnalyticsClientInterface
    
    init(hippoAnalyticsClient: HippoAnalyticsClientInterface) {
        self.hippoAnalyticsClient = hippoAnalyticsClient
    }
    
    func log(name: String, properties: [String : Any]) {
        hippoAnalyticsClient.logEvent(named: name, properties: properties)
    }
}
