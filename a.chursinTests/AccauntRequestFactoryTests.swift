import Foundation
import Alamofire
import XCTest
import OHHTTPStubs
@testable import a_chursin



class AccauntRequestFactoryTests: XCTestCase
{
    var accaunt: AccauntRequestFactory!
    var userData: UserData!
    
    override func setUp()
    {
        super.setUp()
        userData =  UserData(id: 123, username: "username", password: "password", email: "fuck@android", gender: "m", creditCard: "2312 3334 2342 2342", bio: "bio")
        let factory = RequestFactoryMock()
        accaunt = factory.makeAccauntRequestFactory()
    }
    
    override func tearDown()
    {
        super.tearDown()
        
        userData = nil
        accaunt = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testReg()
    {
        let exp = expectation(description: "")
        
        OHHTTPStubsResponse.stubHelper(pathEnd: "registerUser.json", file: "Register")
        
        var registerResult: RegisterResult?

        accaunt.register(userData: userData){
            result in
            registerResult = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        
        XCTAssertNotNil(registerResult)
    }
    
    func testChange()
    {
        let exp = expectation(description: "")
        
        OHHTTPStubsResponse.stubHelper(pathEnd: "changeUserData.json", file: "Change")
        
        var changeResult: ChangeResult?

        accaunt.changeOptions(userData: userData){
            result in
            changeResult = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        
        XCTAssertNotNil(changeResult)
    }
    
    
}
