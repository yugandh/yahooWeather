//
//  yahooWeatherTests.swift
//  yahooWeatherTests
//
//  Created by Yugandhar Kommineni on 11/28/17.
//  Copyright © 2017 Yugandhar Kommineni. All rights reserved.
//

import XCTest
@testable import yahooWeather

class yahooWeatherTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
    }
    
    func testServiceResponse() {
        let service = YahooWeaherService()
        
        // success response will register test case should pass
        let expectations = expectation(description: "service method will get executed")
        service.weatherData {
            expectations.fulfill()
        }
        
        // test case will fail if you disconnect to wifi and run test case and if response is also less than a 1 second it will fail
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }
    
    func testCloseButtonHideen() {
        let v = ForecastViewController()
        XCTAssertFalse(v.closeButton.isHidden, "close button is hidden")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
