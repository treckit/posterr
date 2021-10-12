//
// Created by Dmytro Seredinov
//


import Foundation
import SwiftUI

struct PostDetailsView: View
{
    public var post: Post

    init(_ post: Post)
    {
        self.post = post
    }
    
    public var body: some View
    {
        VStack
        {
            UserSection(post.user!)
            Text(post.title).font(.title).lineLimit(1).truncationMode(.tail)
            Text(post.body).font(.body).lineLimit(3)
            Spacer()
        }
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(post.title)
    }
    
    
    struct UserSection: View
    {
        public var user: User

        init(_ user: User)
        {
            self.user = user
        }
        
        public var body: some View
        {
            HStack(alignment: .center , spacing: 5) {
                if let image = user.photo?.image()
                {
                    Image(uiImage: image).clipShape(Circle()).padding(15)
                }
                else
                {
                    let initials = user.name.split(separator: " ").compactMap { (substr: Substring) in
                        "\(substr)".substring(toIndex: 1)
                    }.joined(separator: "")
                    
                    Text(initials)
                        .font(.title)
                        .fontWeight(.black)
                        .padding(15)
                        .background(.blue)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
                VStack(alignment: .leading, spacing: 10.0)
                {
                    Text(user.name).font(.title2).lineLimit(1).truncationMode(.tail)
                    Text(user.email).font(.body).lineLimit(2).foregroundColor(.blue)
                    
                    if let address = user.address
                    {
                        Text(address.format()).font(.body).lineLimit(3)
                    }
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .topLeading
                )
            }
        }
    }
}
