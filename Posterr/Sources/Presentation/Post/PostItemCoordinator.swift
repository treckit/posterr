//
// Created by Dmytro Seredinov
//


import Foundation
import SwiftUI

public class PostItemCoordinator: ObservableObject, Identifiable
{
    @Published var viewModel: PostViewModel

    private let parent: PostCollectionCoordinator
    
    init(_ viewModel: PostViewModel, parent: PostCollectionCoordinator)
    {
        self.viewModel = viewModel
        self.parent = parent
    }
    
    public func mail(to user: User, subject: String = "Posterr Feedback")
    {
        guard
            let url = URL(string: "mailto:\(user.email)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")")
        else
        {
           return
        }
        
        if UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url, options: [:]) { opened in
                print("Mail App Opened")
            }
        }
    }
}
