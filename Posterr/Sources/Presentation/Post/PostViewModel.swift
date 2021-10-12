//
// Created by Dmytro Seredinov
//

import Foundation
import Combine

public class PostViewModel: ViewModel
{
    @Published var item: Post

    let interactor: PostInteractor

    init(_ post: Post, interactor: PostInteractor) {
        self.item = post
        self.interactor = interactor
    }

    public func reload()
    {
        self.loading = true
        
        interactor.repository.read(self.item.id).sink { result in
            if case let .failure(err) = result
            {
                self.error = err
            }
            
            self.loading = false
            
        } receiveValue: { value in
            self.item = value
        }
        .store(in: &cancellables)
    }
}
