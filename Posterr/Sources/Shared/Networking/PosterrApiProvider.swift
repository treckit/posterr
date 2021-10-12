//
// Created by Dmytro Seredinov
//

import Foundation
import Combine
import Moya

public class PosterrApiProvider<TargetEndpoint> where TargetEndpoint: PosterrApiEndpoint
{
    /// Closure that defines the endpoints for the provider.
    public typealias EndpointClosure = (URL, TargetEndpoint) -> Endpoint

    /// Default Endpoint's generation closure for dynamic base URL
    public var endpointClosure: EndpointClosure = { (host, target) in
        return Endpoint(
                url: host.appendingPathComponent(target.path).absoluteString,
                sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
        )
    }

    public lazy var provider: MoyaProvider<TargetEndpoint> =
    {
        return MoyaProvider { (target: TargetEndpoint) in
            var host = self.host
            if target.baseURL.absoluteString != "about:blank"
            {
                host = target.baseURL
            }
            
            return self.endpointClosure(host, target)
        }
    }()

    public let host: URL

    public init(host: URL) {
        self.host = host
    }
    
    public func call<T>(_ endpoint: TargetEndpoint, for type: T.Type) -> AnyPublisher<T, Posterr.Error> where T: Decodable
    {
        return provider.requestPublisher(endpoint)
                .map(T.self)
                .mapError{ Posterr.Error.wrap($0) }
                .eraseToAnyPublisher()
    }
}

public struct PosterrApiError: Swift.Error
{
    public var message: String?
    public var wrapped: Swift.Error?

    init(_ messsage: String?, wrapped: Error? = nil)
    {
        self.message = messsage
        self.wrapped = wrapped
    }
    
    public static func wrap(_ error: Error) -> PosterrApiError
    {
        return self.init(nil, wrapped: error)
    }
}

public protocol PosterrApiEndpoint: Moya.TargetType {}
extension PosterrApiEndpoint
{
    /// Drop-in default substitution to conform to TargetType Protocol
    /// without deep modifications
    public var baseURL: URL {
        URL(string: "about:blank")!
    }
    
    /// Consuming JSON API is first priority
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
