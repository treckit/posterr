//
// Created by Dmytro Seredinov
//

import Foundation
import Combine
import Moya

public struct PostNetworkDataSource
{
    private var provider: PosterrApiProvider<PostNetworkEndpoints>
    
    init(_ host: URL)
    {
        self.provider = PosterrApiProvider<PostNetworkEndpoints>(host: host)
    }
}

extension PostNetworkDataSource: PostRepositoryInterface
{
    public func browse() -> AnyPublisher<[Post], Posterr.Error>
    {
        return browse(detailed: true)
    }

    public func browse(detailed: Bool = false) -> AnyPublisher<[Post], Posterr.Error>
    {
        let posts = self.provider.call(.browse, for: [Post].self).eraseToAnyPublisher()
        
        if (!detailed)
        {
            return posts
        }
        
        return posts.flatMap { posts in
            posts.publisher.flatMap { details(for: $0) }
            .collect()
        }.eraseToAnyPublisher()
    }
    
    public func details(for post: Post) -> AnyPublisher<Post, Posterr.Error>
    {
        return Publishers.CombineLatest(read(post.id), user(post.userId)).map { (p, u) in
            var post = p
            post.user = u
            
            return post
        }
        .eraseToAnyPublisher()
    }
    
    public func read(_ id: Int) -> AnyPublisher<Post, Posterr.Error> {
        return self.provider.call(.read(id), for: Post.self)
    }
    
    public func user(_ id: Int) -> AnyPublisher<User, Posterr.Error> {
        return self.provider.call(.user(id), for: User.self)
    }
}
