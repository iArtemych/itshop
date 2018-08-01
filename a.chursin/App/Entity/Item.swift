// Структуры хранящие результаты запросов по товарам

import Foundation

struct GoodsResult: Codable
{
    let idProduct: Int
    let productName: String
    let price: Int
    
    enum CodingKeys: String, CodingKey
    {
        case idProduct = "id_product"
        case productName = "product_name"
        case price = "price"
    }
}

struct ItemResult : Codable
{
    let result: Int
    let productName: String
    let productPrice: Int
    let productDescription: String
    
    enum CodingKeys: String, CodingKey
    {
        case result = "result"
        case productName = "product_name"
        case productPrice = "product_price"
        case productDescription = "product_description"
    }
}

struct ItemRequest
{
    let pageNumber: Int
    let idCategory: Int
}


