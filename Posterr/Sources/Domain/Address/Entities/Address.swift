//
// Created by Dmytro Seredinov
//

import Foundation
import ObjectMapper
import CoreLocation
import GRDB

public struct Address: Decodable
{
    public var id: Int?
    public var street: String?
    public var suite: String?
    public var city: String?
    public var zipcode: String?
    public var geo: Location?
    public var userId: Int?
    
    enum CodingKeys: String, CodingKey
    {
        case street = "street"
        case suite = "suite"
        case city = "city"
        case zipcode = "zipcode"
        case geo = "geo"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.street = try container.decode(String?.self, forKey: .street)
        self.suite = try container.decode(String?.self, forKey: .suite)
        self.city = try container.decode(String?.self, forKey: .city)
        self.zipcode = try container.decode(String?.self, forKey: .zipcode)
        
//        self.geo = try container.decode(String?.self, forKey: .geo)
//        guard let coords = try container.decode(
    }
    
    public init?(map: Map) {
        
    }
    
    public mutating func mapping(map: Map) {
        
    }
    
    public func format() -> String
    {
        return "\(street ?? "") \(suite ?? "") \(city ?? "") \(zipcode ?? "")"
    }
}

extension Address
{
    struct GeoLocationDecoder {
        enum Key: String, CodingKey {
            case latitude
            case longitude
        }

        func create(from decoder: Decoder) throws -> CLLocation {
            let container = try decoder.container(keyedBy: Key.self)
            let latitude = try container.decode(Double.self, forKey: .latitude)
            let longitude = try container.decode(Double.self, forKey: .longitude)
            return CLLocation(latitude: latitude, longitude: longitude)
        }
    }
}

extension Address: Identifiable
{
    
}

extension CLLocation: Encodable {
    public enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case altitude
        case horizontalAccuracy
        case verticalAccuracy
        case speed
        case course
        case timestamp
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
        try container.encode(altitude, forKey: .altitude)
        try container.encode(horizontalAccuracy, forKey: .horizontalAccuracy)
        try container.encode(verticalAccuracy, forKey: .verticalAccuracy)
        try container.encode(speed, forKey: .speed)
        try container.encode(course, forKey: .course)
        try container.encode(timestamp, forKey: .timestamp)
    }
}

public struct Location: Decodable {
    var location: CLLocation
    
    init(location: CLLocation) {
        self.location = location
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CLLocation.CodingKeys.self)
        
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        let altitude = try container.decode(CLLocationDistance.self, forKey: .altitude)
        let horizontalAccuracy = try container.decode(CLLocationAccuracy.self, forKey: .horizontalAccuracy)
        let verticalAccuracy = try container.decode(CLLocationAccuracy.self, forKey: .verticalAccuracy)
        let speed = try container.decode(CLLocationSpeed.self, forKey: .speed)
        let course = try container.decode(CLLocationDirection.self, forKey: .course)
        let timestamp = try container.decode(Date.self, forKey: .timestamp)
        
        let location = CLLocation(coordinate: CLLocationCoordinate2DMake(latitude, longitude), altitude: altitude, horizontalAccuracy: horizontalAccuracy, verticalAccuracy: verticalAccuracy, course: course, speed: speed, timestamp: timestamp)
        
        self.init(location: location)
    }
}

struct GeoLocationDecoder {
    enum Key: String, CodingKey {
        case latitude
        case longitude
    }

    func create(from decoder: Decoder) throws -> CLLocation {
        let container = try decoder.container(keyedBy: Key.self)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}
