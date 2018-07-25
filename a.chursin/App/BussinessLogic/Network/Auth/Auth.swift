//
//  Auth.swift
//  a.chursin
//
//  Created by Артем Чурсин on 15.07.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

import Foundation
import Alamofire

class Auth: AbstractRequestFatory
{    
    let errorParser: AbstractErrorParser
    let sessionManager: SessionManager
    let queue: DispatchQueue?
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: SessionManager,
        queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
    
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Auth: AuthRequestFactory
{
    func login(userName: String, password: String, comletionHandler: @escaping (DataResponse<LoginResult>) -> Void)
    {
        let requestModel = Login(baseURL: baseUrl, login: userName, password: password)
        self.request(reques: requestModel, completionHandler: comletionHandler)
    }
    //--
    func logout(comletionHandler: @escaping (DataResponse<LogoutResult>) -> Void)
    {
        let requestModel = Logout(baseURL: baseUrl)
        self.request(reques: requestModel, completionHandler: comletionHandler)
    }
    //--
    struct Login: RequestRouter
    {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "login.json"
        
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password
            ]
        }
    }
    
    
    struct Logout: RequestRouter
    {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "logout.json"
        
        let id = "123"
        var parameters: Parameters? {
            return ["id_user": id,]
        }
    }
    
}

