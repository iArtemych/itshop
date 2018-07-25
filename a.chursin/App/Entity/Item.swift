//
//  Item.swift
//  a.chursin
//
//  Created by Артем Чурсин on 25.07.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

import Foundation

struct GoodsResult: Codable
{
    let id_product: Int
    let product_name: String
    let price: Int
}

struct ItemResult : Codable
{
    let result: Int
    let product_name: String
    let product_price: Int
    let product_description: String
}

struct ItemRequest
{
    let pageNumber: Int
    let idCategory: Int
}

