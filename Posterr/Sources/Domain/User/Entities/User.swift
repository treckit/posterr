//
// Created by Dmytro Seredinov
//

import Foundation
import GRDB
import ObjectMapper

public struct User: Decodable
{
    public var id: Int
    public var name: String
    public var email: String
    public var phone: String
    public var website: String
    public var address: Address?
    public var photo: Media?
    
    enum CodingKeys: String, CodingKey
    {
        case id = "id"
        case name = "name"
        case email = "email"
        case phone = "phone"
        case website = "website"
        case address = "address"
    }
}

extension User: Identifiable
{

}

/// Feature: SQLite-persisted record
extension User: FetchableRecord, PersistableRecord
{
    public func encode(to container: inout PersistenceContainer) {
        
    }
}
