//
//  HippoAnalyticsClient+EventLogging.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 29.01.2022.
//

import HippoAnalytics

extension HippoAnalyticsClient: EventLogging {
    
    func log(name: String, properties: [String : Any]) {
        logEvent(named: name, properties: properties)
    }
}

