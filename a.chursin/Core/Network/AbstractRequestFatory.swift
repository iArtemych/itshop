//
//  AbstractRequestFatory.swift
//  a.chursin
//
//  Created by Артем Чурсин on 14.07.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

import Foundation
import Alamofire

protocol AbstractRequestFatory
{
    var errorParser: AbstractErrorParser {get}
    var sessionManager: SessionManager {get}
    var queue: DispatchQueue? {get}
    
    @discardableResult
    func request<T: Decodable>(
        reques: URLRequestConvertible,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> DataRequest
}
extension AbstractRequestFatory
{
    @discardableResult
    public func request<T: Decodable>(
        reques: URLRequestConvertible,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> DataRequest {
            return sessionManager
                .request(reques)
                .responseCodable(errorParser: errorParser, queue: queue, completionHandler: completionHandler)
        }
}

