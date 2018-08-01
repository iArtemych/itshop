// Структуры хранящие результаты запросов в корзину
import Foundation

struct BasketAddResult: Codable
{
    let result: Int
}

struct BasketRemoveResult: Codable
{
    let result: Int
}

struct BasketGetResult: Codable
{
    let amount: Int
    let countGoods: Int
    let contents: [BasketContents]
}

struct BasketContents: Codable
{
    let idProduct: Int
    let productName: String
    let price: Int
    let quantity: Int
    
    enum CodingKeys: String, CodingKey {
        case idProduct = "id_product"
        case productName = "product_name"
        case price = "price"
        case quantity = "quantity"
    }
}


