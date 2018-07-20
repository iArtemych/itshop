//
//  RequestRouter.swift
//  a.chursin
//
//  Created by Артем Чурсин on 14.07.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

import Foundation
import Alamofire

enum RequestRouterEncoding
{
    case url, json
}

protocol RequestRouter: URLRequestConvertible
{
    var baseURL: URL {get}
    var method: HTTPMethod {get}
    var path: String {get}
    var parameters: Parameters? {get}
    var fullURL: URL {get}
    var encoding: RequestRouterEncoding {get}
}

extension RequestRouter
{
    var fullURL: URL
    {
        return baseURL.appendingPathComponent(path)
    }
    var encoding: RequestRouterEncoding
    {
        return .url
    }
    
    func asURLRequest() throws -> URLRequest
    {
        var urlReqest = URLRequest(url: fullURL)
        urlReqest.httpMethod = method.rawValue
        
        switch self.encoding
        {
        case .url:
            return try URLEncoding.default.encode(urlReqest, with: parameters)
        case .json:
            return try JSONEncoding.default.encode(urlReqest, with: parameters)
        }
    }
}

