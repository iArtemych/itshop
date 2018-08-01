import Foundation
import Alamofire
import XCTest
import OHHTTPStubs
@testable import a_chursin



class ProductRequestFactoryTests: XCTestCase
{
    var product: ProductRequestFactory!
    var itemRequest: ItemRequest!
    
    override func setUp()
    {
        super.setUp()
        
        let factory = RequestFactoryMock()
        product = factory.makeProductRequestFactory()
        itemRequest = ItemRequest(pageNumber: 1, idCategory: 1)
    }
    
    override func tearDown()
    {
        super.tearDown()
        
        product = nil
        OHHTTPStubs.removeAllStubs()
        itemRequest = nil
    }
    
    func testProductList()
    {
        let exp = expectation(description: "")
        
        OHHTTPStubsResponse.stubHelper(pathEnd: "catalogData.json", file: "Catalog")
        
        var itemResult: [GoodsResult]?
        
        
        product.productList(itemRequest: itemRequest){
            result in
            itemResult = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        
        XCTAssertNotNil(itemResult)
    }
    
    func testGood()
    {
        let exp = expectation(description: "")
        
        OHHTTPStubsResponse.stubHelper(pathEnd: "getGoodById.json", file: "Item")
        
        var itemResult: ItemResult?
        
        product.productItem(idProduct: 1){
            result in
            itemResult = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        
        XCTAssertNotNil(itemResult)
    }
    
}
