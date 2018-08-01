// фабрика забросов к товарам
import Foundation
import Alamofire

protocol ProductRequestFactory
{
    func productList(
        itemRequest: ItemRequest,
        comletionHandler: @escaping (DataResponse<[GoodsResult]>) -> Void
    )
    
    func productItem(
        idProduct: Int,
        comletionHandler: @escaping (DataResponse<ItemResult>) -> Void
    )
}
