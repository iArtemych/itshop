//
//  ProductRequestFactory.swift
//  a.chursin
//
//  Created by Артем Чурсин on 25.07.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

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
