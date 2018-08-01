// Класс в котором создаются и настраиваются запросы к API для работы с товарами
import Foundation
import Alamofire

class Product: BaseRequestFactory, ProductRequestFactory
{
    func productList(itemRequest: ItemRequest, comletionHandler: @escaping (DataResponse<[GoodsResult]>) -> Void)
    {
        let requestModel = ListResp(baseURL: baseUrl, itemRequest: itemRequest)
        self.request(reques: requestModel, completionHandler: comletionHandler)
        
    }
    func productItem(idProduct: Int, comletionHandler: @escaping (DataResponse<ItemResult>) -> Void)
    {
        let requestModel = ItemResp(baseURL: baseUrl, idProduct: idProduct)
        self.request(reques: requestModel, completionHandler: comletionHandler)
    }
}

extension Product
{
    struct ListResp: RequestRouter
    {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "catalogData.json"
        
        let itemRequest: ItemRequest
        
        var parameters: Parameters? {
            return[
                "page_number": itemRequest.pageNumber,
                "id_category": itemRequest.idCategory,
            ]
        }
    }
    
    struct ItemResp: RequestRouter
    {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "getGoodById.json"
        
        
        let idProduct: Int
        
        var parameters: Parameters? {
            return[
                "id_product": idProduct
            ]
        }
    }
}
