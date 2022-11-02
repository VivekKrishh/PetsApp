//
//  PetListTest.swift
//  PetsApp_VivekTests
//

import XCTest
@testable import PetsApp_Vivek

class PetListTest: XCTestCase {
    
    var systemUnderTest: PetsListViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        systemUnderTest = PetsListViewModel()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        systemUnderTest = nil
    }
    
    
    func testParseWorkingTime_WhenDecodePassess_ReturnValidTime() {
        //Arrange
        let expectation = expectation(description: "check parse working time")
        let filePath = DataManager.shared.getfilePath(for: Operation.WORKING_TIME)
        systemUnderTest.fetchWorkingTime(filePath: filePath!) { openTime, closeTime, error in
            //Assert
            XCTAssertNotNil(openTime)
            XCTAssertNotNil(closeTime)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4.0)
    }
    
    func testParseWorkingTime_WhenInvalidPathProvided_ReturnFilePathError() {
        let expectation = expectation(description: "Expectation for file path error")
        let filePath = DataManager.shared.getfilePath(for: Operation.WORKING_TIME)
        //Bundle.main.path(forResource: Operation.WORKING_TIME.getJsonFiles().rawValue, ofType: "json")
        systemUnderTest.fetchWorkingTime(filePath: filePath!) { openTime, closeTime, error in
            if let filePathError = error {
                XCTAssertEqual(filePathError,PetsError.filePathError)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    
    func testParseWorkingTime_WhenValidFilePathProvided_ReturnFilePathSuccess() {
        let expectation = expectation(description: "Expectation for valid file path")
        let filePath = DataManager.shared.getfilePath(for: Operation.WORKING_TIME)
        //Bundle.main.path(forResource: Operation.WORKING_TIME.getJsonFiles().rawValue, ofType: "json")
        systemUnderTest.fetchWorkingTime(filePath: filePath!) { openTime, closeTime, error in
            if error == nil {
                XCTAssertNotNil(openTime)
                XCTAssertNotNil(closeTime)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    
}

