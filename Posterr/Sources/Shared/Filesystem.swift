//
// Created by Dmytro Seredinov
//


import Foundation

public struct Filesystem
{
    public static let shared: Filesystem = Filesystem()
    
    private let manager: FileManager = FileManager.default

    public var directory: URL
    {
        let documents = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documents.appendingPathComponent("Posterr")
    }

    fileprivate init()
    {
        _ = ensureDirectoryExists(directory.path, absolute: true)
    }
    
    public func ensureDirectoryExists(_ name: String, absolute: Bool = false) -> String?
    {
        let path = !absolute ? path(for: name) : name
        
        var isDir: ObjCBool = false
        
        if !manager.fileExists(atPath: path, isDirectory: &isDir) || !isDir.boolValue
        {
            do {
                try manager.createDirectory(at: URL(fileURLWithPath: path, isDirectory: true), withIntermediateDirectories: true, attributes: nil)
            } catch {
                return nil
            }
        }
        
        return path
    }
    
    public func path(for file: String) -> String
    {
        return directory.standardizedFileURL.appendingPathComponent(file).absoluteString
    }
    
    public func exist(_ file: String) -> Bool
    {
        return manager.fileExists(atPath: path(for: file))
    }
    
    public func read(_ file: String) -> Data?
    {
        if (!exist(file))
        {
            return nil
        }
        
        return manager.contents(atPath: path(for: file))
    }
}
