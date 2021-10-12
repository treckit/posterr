//
//  Created by Dmytro Seredinov
//

import Foundation
import Moya

public enum PostNetworkEndpoints
{
    /// Get list of Posts from REST API
    case browse
    
    /// Read particular Post's details
    case read(_ id: Int)
    
    case user(_ id: Int)
}

extension PostNetworkEndpoints: PosterrApiEndpoint
{
    public var path: String {
        switch self {
        case .browse:
            return "/posts"
        case .read(let id):
            return "/posts/\(id)"
        case .user(let id):
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

extension PostNetworkEndpoints
{
    public var sampleData: Data
    {
        switch self {
        case .browse:
            guard
                let url = Bundle.main.url(forResource: "accounts", withExtension: "json"),
                let data = try? Data(contentsOf: url)
            else
            {
                return Data()
            }
            return data
        case .read(let id):
            return """
              {
                "userId": "1",
                "id": "\(id)",
                "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
              }
            """.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).data(using: .utf8) ?? Data()
        case .user(let id):
            return UserNetworkEndpoints.read(id).sampleData
        }
    }
}
