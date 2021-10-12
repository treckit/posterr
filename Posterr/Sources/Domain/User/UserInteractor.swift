//
// Created by Dmytro Seredinov
//

import Foundation

public class UserInteractor
{
    public let repository: UserRepositoryInterface
    
    public init(repository: UserRepositoryInterface) {
        self.repository = repository
    }
}
