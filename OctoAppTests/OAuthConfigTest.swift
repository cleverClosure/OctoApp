//
//  OctoAppTests.swift
//  OctoAppTests
//
//  Created by Tim on 05.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import XCTest
@testable import OctoApp

class OAuthConfigTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
   
    
    func testInit_authPathIsNotNil() {
        let config = OAuthConfig()
        XCTAssert(config.authPath != nil)
    }
    
    func testswapCodeForToken_ShouldReturnNil() {
        let exp = expectation(description: "Expecting to return nil")
        let config = OAuthConfig()
        config.swapCodeForToken(receivedCode: "123") { res in
            if res != nil {
                XCTFail()
            } else {
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 5)
    }
    

    
}
