// фабрика забросов к отзывам
import Foundation
import Alamofire

protocol ReviewsReqestFactory
{
    func addReview(
        idUser: Int,
        text: String,
        comletionHandler: @escaping (DataResponse<ReviewAddResult>) -> Void
    )
    
    func removeReview(
        idComment: Int,
        comletionHandler: @escaping (DataResponse<RemoveReviewResult>) -> Void
    )
    func approveReview(
        idComment: Int,
        comletionHandler: @escaping (DataResponse<ApproveReviewResult>) -> Void
    )
}
