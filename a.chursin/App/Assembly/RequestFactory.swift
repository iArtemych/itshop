//
//  RequestFactory.swift
//  a.chursin
//
//  Created by Артем Чурсин on 15.07.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

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
    
}
