//
//  AuthRequestFactory.swift
//  a.chursin
//
//  Created by Артем Чурсин on 15.07.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

import Foundation
import Alamofire

protocol AuthRequestFactory
{
    func login(
        userName: String,
        password: String,
        comletionHandler: @escaping (DataResponse<LoginResult>) -> Void
    )
    //--
    func logout(comletionHandler: @escaping (DataResponse<LogoutResult>) -> Void)
}
