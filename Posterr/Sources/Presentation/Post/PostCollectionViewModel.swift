//
// Created by Dmytro Seredinov
//


import Foundation
import Combine

public class PostCollectionViewModel: ViewModel
{
    @Published var items: [Post] = []
    
    let interactor: PostInteractor

    init(interactor: PostInteractor) {
        self.interactor = interactor
    }

    public func reload()
    {
        self.loading = true
        
        interactor.repository.browse().sink { result in
            if case let .failure(err) = result
            {
                self.error = err
            }
            
            self.loading = false
            
        } receiveValue: { value in
            self.items = value
        }
        .store(in: &cancellables)
    }
    
    
}
