/// фабрика забросов к корзине
import Foundation
import Alamofire

protocol BasketReqestFactory
{
    func addToBasket(
        idProduct: Int,
        quantity: Int,
        comletionHandler: @escaping (DataResponse<BasketAddResult>) -> Void
    )
    
    func removeFromBasket(
        idProduct: Int,
        comletionHandler: @escaping (DataResponse<BasketRemoveResult>) -> Void
    )
    func getBasket(
        idUser: Int,
        comletionHandler: @escaping (DataResponse<BasketGetResult>) -> Void
    )
}
