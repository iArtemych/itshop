// Фабрика созающая запросы к API
import Foundation
import Alamofire

class RequestFactory
{
    func makeErrorParser() -> AbstractErrorParser
    {
        return ErrorParser​()
    }
    
    lazy var commonSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
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
