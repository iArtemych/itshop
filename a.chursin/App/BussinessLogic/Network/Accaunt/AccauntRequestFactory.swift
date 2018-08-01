// фабрика забросов к аккаунту
import Foundation
import Alamofire

protocol AccauntRequestFactory
{
    func register(
        userData: UserData,
        comletionHandler: @escaping (DataResponse<RegisterResult>) -> Void
    )
    
    func changeOptions(
        userData: UserData,
        comletionHandler: @escaping (DataResponse<ChangeResult>) -> Void
    )
}


