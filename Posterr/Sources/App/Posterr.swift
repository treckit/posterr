//
// Created by Dmytro Seredinov
//


import Foundation
import Swinject

public class Posterr: ObservableObject
{
    public static let shared: Posterr = Posterr()
    
    @Published public var posts: PostCollectionViewModel!
    
    var config: AppConfig = AppConfig.defaults()
    
    let container: Container = Container()
    
    fileprivate init()
    {
        boot()
    }
    
    private func boot()
    {
        container.register(PostRepositoryInterface.self) { _ in
            PostNetworkDataSource(self.config.host)
        }
        
        container.register(PostInteractor.self) { resolver in
            PostInteractor(repository: resolver.resolve(PostRepositoryInterface.self)!)
        }

        container.register(PostCollectionViewModel.self) { resolver in
            PostCollectionViewModel(interactor: resolver.resolve(PostInteractor.self)!)
        }
        
        posts = container.resolve(PostCollectionViewModel.self)!
    }
    
    public func configure(with config: AppConfig)
    {
        self.config = config
        
        boot()
    }
}

extension Posterr
{
    public struct Error: Swift.Error
    {
        public var message: String?
        public var wrapped: Swift.Error?

        init(_ messsage: String?, wrapped: Swift.Error? = nil)
        {
            self.message = messsage
            self.wrapped = wrapped
        }
        
        public static func wrap(_ error: Swift.Error) -> Self
        {
            return self.init(nil, wrapped: error)
        }
        
        public static func notImplemented() -> Self
        {
            return self.init("Not Implemented", wrapped: nil)
        }
        
    }
}
