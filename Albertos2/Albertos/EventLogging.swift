//
//  EventLogging.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 29.01.2022.
//

import Foundation

protocol EventLogging {
    
    func log(name: String, properties: [String: Any])
}
