//
// Created by Dmytro Seredinov
//

import Foundation
import Combine

public protocol UserRepositoryInterface
{
    func read(_ id: Int) -> AnyPublisher<User?, Error>
}
