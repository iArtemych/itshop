import Foundation
import XCTest
@testable import a_chursin

struct ErrorParser​Stub: AbstractErrorParser
{
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalerror
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
    {
        return error
    }
}
