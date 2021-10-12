//
// Created by Dmytro Seredinov
//


import Foundation
import Moya

public enum UserNetworkEndpoints
{
    /// Read particular User's details
    case read(_ id: Int)
    
}

extension UserNetworkEndpoints: PosterrApiEndpoint
{
    public var path: String {
        switch self {
        case .read(let id):
            return "/users/\(id)"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        return .requestPlain
    }
}

extension UserNetworkEndpoints
{
    public var sampleData: Data
    {
        switch self {
        case .read(let id):
            return """
            {
              "id": \(id),
              "name": "Leanne Graham",
              "username": "Bret",
              "email": "Sincere@april.biz",
              "address": {
                "street": "Kulas Light",
                "suite": "Apt. 556",
                "city": "Gwenborough",
                "zipcode": "92998-3874",
                "geo": {
                  "lat": "-37.3159",
                  "lng": "81.1496"
                }
              },
              "phone": "1-770-736-8031 x56442",
              "website": "hildegard.org",
              "company": {
                "name": "Romaguera-Crona",
                "catchPhrase": "Multi-layered client-server neural-net",
                "bs": "harness real-time e-markets"
              }
            }
            """.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).data(using: .utf8) ?? Data()
        }
    }
}
