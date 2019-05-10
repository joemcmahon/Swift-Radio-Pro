//
//  SwiftRadioSnapshots.swift
//  SwiftRadioSnapshots
//
//  Created by Joe McMahon on 7/16/18.
//  Copyright © 2018 matthewfecher.com. All rights reserved.
//

import XCTest

let app = XCUIApplication()

class SwiftRadioSnapshots: XCTestCase {
    let stations = app.cells
    let hamburgerMenu = app.navigationBars["Swift Radio"].buttons["icon-hamburger"]
    let pauseButton = app.buttons["btn-stop"]
    let playButton = app.buttons["btn-play"]
    let stopButton = app.buttons["btn-stop"]
    let shareButton = app.buttons["sharing"]
    let volume = app.sliders.element(boundBy: 0)
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        setupSnapshot(app)
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func assertStationsPresent() {
        let numStations:UInt = 1
        XCTAssertEqual(stations.count, Int(numStations))
        
        let texts = stations.staticTexts.count
        XCTAssertEqual(texts, Int(numStations * 2))
    }
    
    func assertHamburgerContent() {
        XCTAssertTrue(app.staticTexts["RadioSpiral"].exists)
    }
    
    func assertAboutContent() {
        XCTAssertTrue(app.buttons["email us!"].exists)
        XCTAssertTrue(app.buttons["radiospiral.net"].exists)
    }
    
    func assertPaused() {
        XCTAssertFalse(pauseButton.isEnabled)
        XCTAssertTrue(playButton.isEnabled)
        XCTAssertTrue(app.staticTexts["Station Paused..."].exists);
    }
    
    func assertStopped() {
        XCTAssertTrue(playButton.isEnabled)
        XCTAssertTrue(app.staticTexts["Station Stopped..."].exists);
    }
    
    func assertPlaying() {
        XCTAssertTrue(pauseButton.isEnabled)
        XCTAssertFalse(app.staticTexts["Station Stopped..."].exists);
    }
    
    func assertStationOnMenu(_ stationName:String) {
        let button = app.buttons["nowPlaying"]
        let value:String = button.label
        XCTAssertTrue(value.contains(stationName))
    }
    
    func assertStationInfo() {
        let textView = app.textViews.element(boundBy: 0)
        if let value = textView.value {
            XCTAssertGreaterThan((value as AnyObject).length, 10)
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func waitForStationToLoad() {
        self.expectation(
            for: NSPredicate(format: "exists == 0"),
            evaluatedWith: app.staticTexts["Loading Station..."],
            handler: nil)
        self.waitForExpectations(timeout: 25.0, handler: nil)
        sleep(5)
        
    }
    
    func waitForTitleToAppear() {
        self.expectation(
            for: NSPredicate(format: "exists = 0"),
            evaluatedWith: app.staticTexts["Captivating Electronica"],
            handler: nil)
        self.waitForExpectations(timeout: 3600.0, handler: nil)
        sleep(5)
    }
    
    func waitForStationToRestart() {
        self.expectation(
            for: NSPredicate(format: "exists == 0"),
            evaluatedWith: app.staticTexts["Station Stopped..."],
            handler:nil)
        self.waitForExpectations(timeout: 10.0, handler: nil)
        sleep(5)
    }
    
    func testMainStationsView() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        assertStationsPresent()
        snapshot("01stations")
        
        /*        hamburgerMenu.tap()
         assertHamburgerContent()
         app.buttons["About"].tap()
         snapshot("02about")
         assertAboutContent()
         app.buttons["Okay"].tap()
         app.buttons["btn close"].tap()
         assertStationsPresent() */
        
        let firstStation = stations.element(boundBy: 0)
        let stationName:String = firstStation.children(matching: .staticText).element(boundBy: 1).label
        assertStationOnMenu("Choose")
        firstStation.tap()
        waitForStationToLoad()
        waitForTitleToAppear()
        snapshot("02coverplay")
        /*        stopButton.tap()
         assertStopped()
         snapshot("04stop")
         playButton.tap()
         waitForStationToRestart()
         waitForTitleToAppear()
         assertPlaying()
        app.navigationBars["Radio Spiral"].buttons["Back"].tap()
        assertStationOnMenu(stationName)
        //snapshot("05playonlist")
        app.navigationBars["Swift Radio"].buttons["btn-nowPlaying"].tap()
        waitForStationToLoad()
        volume.adjust(toNormalizedSliderPosition: 0.2)
        volume.adjust(toNormalizedSliderPosition: 0.8)
        snapshot("06voladjust")
        volume.adjust(toNormalizedSliderPosition: 0.5)
        app.buttons["More Info"].tap()
         assertStationInfo()
         snapshot("06info")
         app.buttons["Okay"].tap() */
        app.buttons["sharing"].tap()
        sleep(2)
        snapshot("07covershare")
    }
}
