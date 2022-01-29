//
//  EventLoggerTest.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 29.01.2022.
//

import XCTest
@testable import Albertos

class EventLoggerTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLogsEventsWithCorrectParameters() throws {
        let hippoAnalyticsSpy = HippoAnalyticsClientInterfaceSpy()
        let eventLogger = EventLogger(hippoAnalyticsClient: hippoAnalyticsSpy)
        
        eventLogger.log(name: "test", properties: ["key": "value"])
        
        XCTAssertEqual(hippoAnalyticsSpy.loggedEvents.count, 1)
        let event = try XCTUnwrap(hippoAnalyticsSpy.loggedEvents.first)
        XCTAssertEqual(event.name, "test")
        XCTAssertEqual(event.properties?["key"] as? String, "value")
    }

}
