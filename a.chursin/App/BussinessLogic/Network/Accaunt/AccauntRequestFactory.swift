//
//  AccauntRequestFactory.swift
//  a.chursin
//
//  Created by Артем Чурсин on 19.07.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

import Foundation
import Alamofire

protocol AccauntRequestFactory
{
    func register(
        userData: UserData,
        comletionHandler: @escaping (DataResponse<RegisterResult>) -> Void
    )
    
    func changeOptions(
        userData: UserData,
        comletionHandler: @escaping (DataResponse<ChangeResult>) -> Void
    )
}


