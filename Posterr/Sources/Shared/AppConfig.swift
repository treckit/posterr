//
// Created by Dmytro Seredinov
//

import Foundation

public struct AppConfig
{
    public static let shared: AppConfig = .defaults()
    
    var storage: UserDefaults = .standard
    
    public var host: URL
    {
        get {
            return storage.url(forKey: "posterr.host") ?? URL(string: "https://jsonplaceholder.typicode.com")!
        }
    
        set {
            storage.set(newValue, forKey: "posterr.host")
        }
    }
    
    init(_ defaults: UserDefaults = .standard) {
        self.storage = defaults
    }
    
    public mutating func use(_ defaults: UserDefaults)
    {
        self.storage = defaults
    }
    
    public static func defaults() -> Self
    {
        return self.init()
    }
}
