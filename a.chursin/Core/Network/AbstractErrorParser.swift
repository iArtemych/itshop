//
//  AbstractErrorParser.swift
//  a.chursin
//
//  Created by Артем Чурсин on 14.07.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

import Foundation

protocol AbstractErrorParser
{
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
