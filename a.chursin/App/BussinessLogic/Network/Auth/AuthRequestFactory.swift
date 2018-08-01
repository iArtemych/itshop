// фабрика забросов ко входу/ выходу из аккаунта
import Foundation
import Alamofire

protocol AuthRequestFactory
{
    func login(
//        userData: UserData,
        login: String,
        password: String,
        comletionHandler: @escaping (DataResponse<LoginResult>) -> Void
    )
    
    func logout(
        userData: UserData,
        comletionHandler: @escaping (DataResponse<LogoutResult>) -> Void
    )
}
