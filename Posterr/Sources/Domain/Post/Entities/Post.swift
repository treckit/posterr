//
// Created by Dmytro Seredinov
//

import Foundation
import GRDB

/// DataTransferObject ab initio
public struct Post: Codable
{
    public var id: Int
    public var title: String
    public var body: String
    public var userId: Int
    
    public var user: User? = nil
    
    enum CodingKeys: String, CodingKey
    {
        case id = "id"
        case title = "title"
        case body = "body"
        case userId = "userId"
    }
    
    mutating public func update(_ closure: (Self) -> Void) -> Self
    {
        var copy = self
        closure(copy)
        
        return copy
    }
}

extension Post: Identifiable
{

}

/// Feature: SQLite-persisted record
extension Post: FetchableRecord, PersistableRecord
{

}
