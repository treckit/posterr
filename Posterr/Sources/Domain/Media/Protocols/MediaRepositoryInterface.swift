//
// Created by Dmytro Seredinov
//

import Foundation
import Combine

public protocol MediaRepositoryInterface
{
    func read(_ id: Int) -> AnyPublisher<Media?, Error>
}
