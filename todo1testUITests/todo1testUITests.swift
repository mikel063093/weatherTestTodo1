//
//  todo1testUITests.swift
//  todo1testUITests
//
//  Created by miguel alegria on 10/30/18.
//  Copyright © 2018 miguel alegria. All rights reserved.
//

import XCTest

class todo1testUITests: XCTestCase {
    
    private var app : XCUIApplication? = nil
    
    override func setUp() {
        continueAfterFailure = false
        self.app = XCUIApplication()
        app?.launch()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRefresh() {
        let refreshButton = self.app?.buttons["ic refresh"]
        XCTAssertTrue((refreshButton?.exists)!)
        refreshButton?.tap()
    }
    
    func testCheckLabls() {
        let refreshButton = self.app?.buttons["ic refresh"]
        let lblSummary = self.app?.buttons["lblSummary"]
        let lblTemperature = self.app?.buttons["lblTemperature"]
        let lblRain = self.app?.buttons["lblRain"]
        let lblCity = self.app?.buttons["lblCity"]
        XCTAssertTrue((lblSummary?.exists)!)
        XCTAssertTrue((lblTemperature?.exists)!)
        XCTAssertTrue((lblRain?.exists)!)
        XCTAssertTrue((lblCity?.exists)!)
        XCTAssertTrue((refreshButton?.exists)!)
        refreshButton?.tap()
    }
    
}
