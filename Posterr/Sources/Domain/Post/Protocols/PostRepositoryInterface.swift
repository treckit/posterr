//
// Created by Dmytro Seredinov
//

import Foundation
import Combine

public protocol PostRepositoryInterface
{
    func browse() -> AnyPublisher<[Post], Posterr.Error>
    func read(_ id: Int) -> AnyPublisher<Post, Posterr.Error>
}
