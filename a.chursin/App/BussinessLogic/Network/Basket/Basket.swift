// Класс в котором создаются и настраиваются запросы к API для работы с корзиной
import Foundation
import Alamofire

class Basket: BaseRequestFactory, BasketReqestFactory
{
    func addToBasket(idProduct: Int, quantity: Int, comletionHandler: @escaping (DataResponse<BasketAddResult>) -> Void)
    {
        let requestModel = AddToBasket(baseURL: baseUrl, idProduct: idProduct, quantity: quantity)
        self.request(reques: requestModel, completionHandler: comletionHandler)
    }
    
    func removeFromBasket(idProduct: Int, comletionHandler: @escaping (DataResponse<BasketRemoveResult>) -> Void)
    {
        let requestModel = RemoveFromBasket(baseURL: baseUrl, idProduct: idProduct)
        self.request(reques: requestModel, completionHandler: comletionHandler)
    }
    
    func getBasket(idUser: Int, comletionHandler: @escaping (DataResponse<BasketGetResult>) -> Void)
    {
        let requestModel = GetBasket(baseURL: baseUrl, idUser: idUser)
        self.request(reques: requestModel, completionHandler: comletionHandler)
    }
}

extension Basket
{
    struct AddToBasket: RequestRouter
    {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "addToBasket.json"
        
        let idProduct: Int
        let quantity: Int
        
        var parameters: Parameters? {
            return[
                "id_product": idProduct,
                "quantity": quantity,
            ]
        }
    }
    
    struct RemoveFromBasket: RequestRouter
    {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "deleteFromBasket.json"
        
        let idProduct: Int
        
        var parameters: Parameters? {
            return[
                "id_product": idProduct,
            ]
        }
    }
    
    struct GetBasket: RequestRouter
    {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "getBasket.json"
        
        let idUser: Int
        
        var parameters: Parameters? {
            return[
                "id_user": idUser,
            ]
        }
    }
}
