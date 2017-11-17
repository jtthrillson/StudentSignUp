//
//  DataManagerTests.swift
//  StudentSignUpTests
//
//  Created by John Wilson on 17/11/2017.
//  Copyright © 2017 Danger Barrel. All rights reserved.
//

import XCTest

class DataManagerTests: XCTestCase, DataManagerDelegate {
    
    var testStudent : Student!
    var dataManager : DataManager!
    var expectation : XCTestExpectation?

    override func setUp() {
        super.setUp()
        dataManager = DataManager()
        testStudent = Student(firstName: "first", lastName: "Last", gender: "Porcupine", email: "google@apple.com", university: "The Streets")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStudentModel() {
        let firstName = "first"
        let lastName = "Last"
        let gender = "Porcupine"
        let email = "google@apple.com"
        let university = "The Streets"
        
        XCTAssertEqual(testStudent.firstName, firstName, "First Name not set correctly in Student")
        XCTAssertEqual(testStudent.lastName, lastName, "Last Name not set correctly in Student")
        XCTAssertEqual(testStudent.gender, gender, "Gender not set correctly in Student")
        XCTAssertEqual(testStudent.email, email, "Email not set correctly in Student")
        XCTAssertEqual(testStudent.university, university, "University not set correctly in Student")
    }
    
    func testFileSaving() {
        dataManager.allStudents.append(testStudent)
        dataManager.saveStudentData(toFile: "test.plist")
        
        // TODO : Split into separate test for loading a file
        
        let testManager = DataManager()
        testManager.loadStudentData(fromFile: "test.plist")
        
        XCTAssert(testManager.allStudents.count == 1, "DataManager failed to retrieve correct data from file")
    }
    
    func testUpload() {
        dataManager.delegate = self
        dataManager.allStudents.append(testStudent)
        
        XCTAssert(dataManager.allStudents.count == 1)

        expectation = expectation(description: "DataManager will complete an upload after 3 seconds")
        
        _ = dataManager.uploadStudent()
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
        XCTAssert(dataManager.allStudents.count == 0, "DataManager upload failed")

    }
    
    @objc func uploadProgress(progress:Float) {
        if progress >= 1.0 {
            expectation?.fulfill()
        }
    }
}
