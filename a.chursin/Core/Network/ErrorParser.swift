//
//  ErrorParser.swift
//  a.chursin
//
//  Created by Артем Чурсин on 14.07.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

import Foundation

class ErrorParser​: AbstractErrorParser
{
    func parse(_ result: Error) -> Error
    {
        return result
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
    {
        return error
    }
}
