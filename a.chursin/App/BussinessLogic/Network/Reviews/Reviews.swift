// Класс в котором создаются и настраиваются запросы к API для работы с отзывами
import Foundation
import Alamofire

class Reviews: BaseRequestFactory, ReviewsReqestFactory
{
    func addReview(idUser: Int, text: String, comletionHandler: @escaping (DataResponse<ReviewAddResult>) -> Void)
    {
        let requestModel = AddNewReview(baseURL: baseUrl, idUser: idUser, text: text)
        self.request(reques: requestModel, completionHandler: comletionHandler)
    }
    
    func removeReview(idComment: Int, comletionHandler: @escaping (DataResponse<RemoveReviewResult>) -> Void)
    {
        let requestModel = RemoveReview(baseURL: baseUrl, idComment: idComment)
        self.request(reques: requestModel, completionHandler: comletionHandler)
    }
    func approveReview(idComment: Int, comletionHandler: @escaping (DataResponse<ApproveReviewResult>) -> Void)
    {
        let requestModel = ApproveReview(baseURL: baseUrl, idComment: idComment)
        self.request(reques: requestModel, completionHandler: comletionHandler)
    }
}

extension Reviews
{
    struct AddNewReview: RequestRouter
    {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "addReview.json"
        
        let idUser: Int
        let text: String
        
        var parameters: Parameters? {
            return[
                "id_user": idUser,
                "text": text,
            ]
        }
    }
    
    struct RemoveReview: RequestRouter
    {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "removeReview.json"
        
        let idComment: Int
        
        var parameters: Parameters? {
            return[
                "id_comment": idComment,
            ]
        }
    }
    
    struct ApproveReview: RequestRouter
    {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "approveReview.json"
        
        let idComment: Int
        
        var parameters: Parameters? {
            return[
                "id_comment": idComment,
            ]
        }
    }
}
