import Foundation
import Alamofire
import XCTest
import OHHTTPStubs
@testable import a_chursin



class ReviewsReqestFactoryTests: XCTestCase
{
    var reviews: ReviewsReqestFactory!
    
    override func setUp()
    {
        super.setUp()
        
        let factory = RequestFactoryMock()
        reviews = factory.makeReviewRequestFactory()
    }
    
    override func tearDown()
    {
        super.tearDown()
        
        reviews = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testAddReview()
    {
        let exp = expectation(description: "")
        
        OHHTTPStubsResponse.stubHelper(pathEnd: "addReview.json", file: "AddReview")
        
        var reviewResult: ReviewAddResult?
        
        reviews.addReview(idUser: 123, text: "Текст отзыва"){
            result in
            reviewResult = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        
        XCTAssertNotNil(reviewResult)
    }
    
    func testRemoveReview()
    {
        let exp = expectation(description: "")

        OHHTTPStubsResponse.stubHelper(pathEnd: "removeReview.json", file: "RemoveReview")

        var reviewResult: RemoveReviewResult?

        reviews.removeReview(idComment: 123){
            result in
            reviewResult = result.value
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)

        XCTAssertNotNil(reviewResult)
    }
    func testApproveReview()
    {
        let exp = expectation(description: "")
        
        OHHTTPStubsResponse.stubHelper(pathEnd: "approveReview.json", file: "ApproveReview")
        
        var reviewResult: ApproveReviewResult?
        
        reviews.approveReview(idComment: 123){
            result in
            reviewResult = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        
        XCTAssertNotNil(reviewResult)
    }

}
