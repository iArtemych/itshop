import Foundation
import OHHTTPStubs

extension OHHTTPStubsResponse
{
    static func stubHelper(pathEnd: String, file: String)
    {
        let end = pathEnd
        let arr = pathEnd.split(separator: ".")
        let fileName = file
        let fileEx = String(arr[1])
        
        stub(condition: isMethodGET() && pathEndsWith(end)) { request in
            let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileEx)!
            return OHHTTPStubsResponse(fileURL: fileURL, statusCode: 200, headers: nil)
        }
    }
}
