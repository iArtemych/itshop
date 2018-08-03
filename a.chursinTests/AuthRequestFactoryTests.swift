import Alamofire
import Foundation
import XCTest
import OHHTTPStubs
@testable import a_chursin

class AuthRequestFactoryTests: XCTestCase
{
    var auth: AuthRequestFactory!
    var userData: UserData!
    
    override func setUp()
    {
        super.setUp()
        
        let factory = RequestFactoryMock()
        auth = factory.makeAuthRequestFactory()
        userData =  UserData(id: 123,
                             username: "username",
                             password: "password",
                             email: "fuck@android",
                             gender: "m",
                             creditCard: "2312 3334 2342 2342",
                             bio: "bio")
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
        
        auth.login(login: userData.username, password: userData.password){
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
        let idUser = 123

        auth.logout(idUser: idUser){
            result in
            logoutResult = result.value
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
        
        XCTAssertNotNil(logoutResult)
    }
}












