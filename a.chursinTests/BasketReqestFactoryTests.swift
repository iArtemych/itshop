import Foundation
import Alamofire
import XCTest
import OHHTTPStubs
@testable import a_chursin

class BasketReqestFactoryTests: XCTestCase
{
    var basket: BasketReqestFactory!
    
    override func setUp()
    {
        super.setUp()
        
        let factory = RequestFactoryMock()
        basket = factory.makeBasketRequestFactory()
    }
    
    override func tearDown()
    {
        super.tearDown()
        
        basket = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testAddBasket()
    {
        let exp = expectation(description: "")
        
        OHHTTPStubsResponse.stubHelper(pathEnd: "addToBasket.json", file: "AddToBasket")
        
        var basketResult: BasketAddResult?
        
        basket.addToBasket(idProduct: 123, quantity: 1){
            result in
            basketResult = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        
        XCTAssertNotNil(basketResult)
    }
    
    func testRemoveBasket()
    {
        let exp = expectation(description: "")
        
        OHHTTPStubsResponse.stubHelper(pathEnd: "deleteFromBasket.json", file: "DeleteFromBasket")
        
        var basketResult: BasketRemoveResult?
        
        basket.removeFromBasket(idProduct: 123){
            result in
            basketResult = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        
        XCTAssertNotNil(basketResult)
    }
    
    func testGetBasket()
    {
        let exp = expectation(description: "")
        
        OHHTTPStubsResponse.stubHelper(pathEnd: "getBasket.json", file: "GetBasket")
        
        var basketResult: BasketGetResult?
        
        basket.getBasket(idUser: 1){
            result in
            basketResult = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        
        XCTAssertNotNil(basketResult)
    }
}
