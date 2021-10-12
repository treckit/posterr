//
// Created by Dmytro Seredinov
//

import Foundation
import SwiftUI

struct PostCollectionView: View
{
    @ObservedObject var viewModel: PostCollectionViewModel
    
    init(_ viewModel: PostCollectionViewModel)
    {
        self.viewModel = viewModel
    }
    
    public var body: some View
    {
        NavigationView
        {
            List
            {
                ForEach(self.viewModel.items) { post in
                    NavigationLink(destination: PostDetailsView(post)){
                        CollectionItemView(post: post)
                    }
                }
            }
            .navigationTitle("Posts")
            .listStyle(.grouped)
            .refreshable {
                self.viewModel.reload()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            self.viewModel.reload()
        }
    }
    
    
    struct CollectionItemView: View
    {
        var post: Post
        
        public var body: some View
        {
            VStack(alignment: .leading, spacing: 8)
            {
                Text(post.title.capitalized)
                    .font(.title2)
                    .lineLimit(1)
                    .truncationMode(.tail)
                if let user = post.user {
                    Text("By \(user.name)")
                        .font(.subheadline)
                        .foregroundColor(Color.secondary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                Text(post.body)
                    .font(.body)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
    }
}
