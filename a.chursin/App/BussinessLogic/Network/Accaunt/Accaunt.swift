// Класс в котором создаются и настраиваются запросы к API для работы с аккаунтом
import Foundation
import Alamofire

class Accaunt: BaseRequestFactory, AccauntRequestFactory
{
    func changeOptions(userData: UserData,comletionHandler: @escaping (DataResponse<ChangeResult>) -> Void )
    {
        let requestModel = ChangeAccaunt(baseURL: baseUrl, userData: userData)
        self.request(reques: requestModel, completionHandler: comletionHandler)
    }
    func register(userData: UserData, comletionHandler: @escaping (DataResponse<RegisterResult>) -> Void)
    {
        let requestModel = RegisterAccaunt(baseURL: baseUrl, userData: userData)
        self.request(reques: requestModel, completionHandler: comletionHandler)
    }
}

extension Accaunt
{
    struct ChangeAccaunt: RequestRouter
    {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "changeUserData.json"
        
        let userData: UserData
        
        var parameters: Parameters? {
            return[
                "username": userData.username,
                "password": userData.password,
                "email": userData.email,
                "gender": userData.gender,
                "credi_card": userData.creditCard,
                "bio": userData.bio
            ]
        }
        
    }
    struct RegisterAccaunt: RequestRouter
    {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "registerUser.json"
        
        let userData: UserData
        
        var parameters: Parameters? {
            return[
                "username": userData.username,
                "password": userData.password,
                "email": userData.email,
                "gender": userData.gender,
                "credi_card": userData.creditCard,
                "bio": userData.bio
            ]
        }
    }
}

