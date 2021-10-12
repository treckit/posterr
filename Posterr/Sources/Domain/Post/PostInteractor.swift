//
// Created by Dmytro Seredinov
//

import Foundation

public class PostInteractor
{
    public let repository: PostRepositoryInterface
    
    public init(repository: PostRepositoryInterface) {
        self.repository = repository
    }
}
