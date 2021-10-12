import Foundation
import SwiftUI
import Combine

public class AppCoordinator: ObservableObject
{
    @Published var postCollectionCoordinator: PostCollectionCoordinator
        
    public init()
    {
        self.postCollectionCoordinator = PostCollectionCoordinator(Posterr.shared.posts)
    }
    
    public func open(_ post: Post)
    {
        
    }
}
