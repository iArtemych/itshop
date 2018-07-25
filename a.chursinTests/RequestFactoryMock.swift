//
//  RequestFactory.swift
//  a.chursin
//
//  Created by Артем Чурсин on 15.07.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

import Foundation
import Alamofire
import XCTest
import OHHTTPStubs
@testable import a_chursin

enum ApiErrorStub: Error
{
    case fatalerror
}

struct ErrorParser​Stub: AbstractErrorParser
{
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalerror
    }

    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
    {
        return error
    }
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
    
}
