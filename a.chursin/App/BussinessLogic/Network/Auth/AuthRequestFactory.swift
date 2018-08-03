// фабрика забросов ко входу/ выходу из аккаунта
import Foundation
import Alamofire

protocol AuthRequestFactory
{
    func login(
        login: String,
        password: String,
        comletionHandler: @escaping (DataResponse<LoginResult>) -> Void
    )
    
    func logout(
        idUser: Int,
        comletionHandler: @escaping (DataResponse<LogoutResult>) -> Void
    )
}
