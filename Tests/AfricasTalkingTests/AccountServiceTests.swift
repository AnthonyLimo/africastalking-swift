//
//  AccountServiceTests.swift
//  AfricasTalking
//
//  Created by Salama Balekage on 01/12/2017.
//

import XCTest
@testable import AfricasTalking

class AccountServiceTests: XCTestCase {
    
    lazy var accountService: AccountService = {
        return AfricasTalking.getAccountService()
    }()
    
    override func setUp() {
        super.setUp()
        AfricasTalking.initialize(username: Fixtures.USERNAME, apiKey: Fixtures.API_KEY)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetUserData() {
        
        let expectation = XCTestExpectation(description: "Gets user balance")
        
        accountService.getUserData { error, data in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            if (data != nil) {
                XCTAssertEqual(data!["UserData"]["balance"].stringValue.starts(with: "KES"), true)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    static var allTests = [
        ("testGetUserData", testGetUserData),
    ]
}

