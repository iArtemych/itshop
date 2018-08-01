import Foundation
import Alamofire
import XCTest
import OHHTTPStubs
@testable import a_chursin

enum ApiErrorStub: Error
{
    case fatalerror
}

class RequestFactoryMock
{
    
    func makeErrorParser() -> AbstractErrorParser
    {
        return ErrorParser​Stub()
    }
    
    lazy var commonSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.ephemeral
        OHHTTPStubs.isEnabled(for: configuration)
        let manager = SessionManager(configuration: configuration)
        return manager
    }()
    let sessionQueue = DispatchQueue.global(qos: .utility)
    func makeAuthRequestFactory() -> AuthRequestFactory
    {
        let errorParser = makeErrorParser()
        return Auth(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue
        )
    }
    func makeAccauntRequestFactory() -> AccauntRequestFactory
    {
        let errorParser = makeErrorParser()
        return Accaunt(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue
        )
    }
    func makeProductRequestFactory() -> ProductRequestFactory
    {
        let errorParser = makeErrorParser()
        return Product(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue
        )
    }
    func makeReviewRequestFactory() -> ReviewsReqestFactory
    {
        let errorParser = makeErrorParser()
        return Reviews(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue
        )
    }
    func makeBasketRequestFactory() -> BasketReqestFactory
    {
        let errorParser = makeErrorParser()
        return Basket(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue
        )
    }
    
}
