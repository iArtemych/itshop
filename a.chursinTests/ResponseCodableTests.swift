import Alamofire
import Foundation
import XCTest
import OHHTTPStubs
@testable import a_chursin

struct PostStub: Codable
{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class ResponseCodableTests: XCTestCase
{
    var errorParser: ErrorParser​Stub!
    
    override func setUp()
    {
        super.setUp()
        
        errorParser = ErrorParser​Stub()
    }
    
    override func tearDown()
    {
        super.tearDown()
        
        errorParser = nil
    }
    
    func testShouldDownloadAndParse()
    {
        let exp = expectation(description: "something")
        var post: PostStub?

        Alamofire
                .request("https://jsonplaceholder.typicode.com/posts/1")
                .responseCodable(errorParser: errorParser) {(response: DataResponse<PostStub>) in
                post = response.value
                exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(post)
    }
}








