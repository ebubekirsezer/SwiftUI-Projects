//
//  HippoAnalyticsClientInterface.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 29.01.2022.
//

import Foundation
import HippoAnalytics

protocol HippoAnalyticsClientInterface {
    
    func logEvent(named name: String, properties: [String: Any])
}

extension HippoAnalyticsClient: HippoAnalyticsClientInterface {
    func logEvent(named name: String, properties: [String : Any]) {
        
    }
}
