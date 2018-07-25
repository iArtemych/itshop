//
//  AuthRequestFactoryTests.swift
//  a.chursinTests
//
//  Created by Артем Чурсин on 21.07.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

import Alamofire
import Foundation
import XCTest
import OHHTTPStubs
@testable import a_chursin



class AuthRequestFactoryTests: XCTestCase
{
    var auth: AuthRequestFactory!
    
    override func setUp()
    {
        super.setUp()
        
        let factory = RequestFactoryMock()
        auth = factory.makeAuthRequestFactory()
    }
    
    override func tearDown()
    {
        super.tearDown()
        
        auth = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testAuth()
    {
        let exp = expectation(description: "")

        OHHTTPStubsResponse.stubHelper(pathEnd: "login.json", file: "Login")
        
        var loginResult: LoginResult?
        
        auth.login(userName: "Somebody", password: "mypassword"){
            result in
            loginResult = result.value
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
        
        XCTAssertNotNil(loginResult)
    }
    
    func testLogout()
    {
        let exp = expectation(description: "")
        
        OHHTTPStubsResponse.stubHelper(pathEnd: "logout.json", file: "Logout")
        
        var logoutResult: LogoutResult?

        auth.logout(){
            result in
            logoutResult = result.value
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
        
        XCTAssertNotNil(logoutResult)
    }
}












