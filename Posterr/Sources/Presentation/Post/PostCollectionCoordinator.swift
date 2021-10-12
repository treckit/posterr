//
// Created by Dmytro Seredinov
//

import Foundation
import SwiftUI

public class PostCollectionCoordinator: ObservableObject
{
    @Published var viewModel: PostCollectionViewModel
    @Published var detailsViewModel: PostViewModel!
        
    public init(_ viewModel: PostCollectionViewModel)
    {
        self.viewModel = viewModel
    }
    
    public func open(_ post: Post)
    {
        self.detailsViewModel = PostViewModel(post, interactor: self.viewModel.interactor)
    }
}
