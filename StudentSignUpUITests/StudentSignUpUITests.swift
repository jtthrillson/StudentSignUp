//
//  StudentSignUpUITests.swift
//  StudentSignUpUITests
//
//  Created by John Wilson on 10/11/2017.
//  Copyright © 2017 Danger Barrel. All rights reserved.
//

import XCTest

class StudentSignUpUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testInitialViews() {
        // test that ~3 views exist, two being buttons.
    }

    func testUploadButton() {
        // test the upload button with no data
        
        // test the upload button with data
    }
    
    func testNewStudentButton() {
        // test that button takes us to the new student view
    }

    func testNewStudentInitial() {
        // test that ~5 text fields exist, along with two buttons.
    }

    func testNewStudentFields() {
        // test acceptable input for fields
    }

}
