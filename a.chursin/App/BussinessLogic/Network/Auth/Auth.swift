// Класс в котором создаются и настраиваются запросы к API для работы со входом и выходм
import Foundation
import Alamofire

class Auth: BaseRequestFactory, AuthRequestFactory
{
    func login(login: String, password: String, comletionHandler: @escaping (DataResponse<LoginResult>) -> Void)
    {
        let requestModel = Login(baseURL: baseUrl, login: login, password: password)
        self.request(reques: requestModel, completionHandler: comletionHandler)
    }
    
    func logout(idUser: Int, comletionHandler: @escaping (DataResponse<LogoutResult>) -> Void)
    {
        let requestModel = Logout(baseURL: baseUrl, idUser: idUser)
        self.request(reques: requestModel, completionHandler: comletionHandler)
    }
}

extension Auth
{
    struct Login: RequestRouter
    {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "login.json"
        
//        let userData: UserData
        let login: String
        let password: String
        
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password
            ]
        }
    }
    
    struct Logout: RequestRouter
    {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "logout.json"
        let idUser: Int
        
        var parameters: Parameters? {
            return ["id_user": idUser]
        }
    }
}

