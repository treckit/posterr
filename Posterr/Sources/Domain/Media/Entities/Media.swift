//
// Created by Dmytro Seredinov
//

import Foundation

// TODO: Needs abstraction layer to declare typealias for AppKit && UIKit image type
import UIKit
import CryptoKit

public struct Media: Codable
{
    // Remote asset URL
    public var url: URL?

    // Which model is owner of the media asset
    public var ownerEntityType: String?

    // Owner's ID
    public var ownerEntityKey: Int?
}

extension Media
{
    public func image() -> UIImage?
    {
        guard
            let url = self.url, Filesystem.shared.exist(hash(string: url.absoluteString))
        else
        {
            return nil
        }
        
        let name = hash(string: url.absoluteString)
        guard
            let data = Filesystem.shared.read(name)
        else
        {
            return nil
        }
        
        return UIImage(data: data)
    }
    
    func hash(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
