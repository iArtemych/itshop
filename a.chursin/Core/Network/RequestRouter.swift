// генерирование маршрута для запроса
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

