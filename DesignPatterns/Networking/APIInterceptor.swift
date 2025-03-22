import Foundation

protocol APIInterceptor { /* Common protocol for Request and response interceptors */ }

protocol APIRequestInterceptor: APIInterceptor {
    func intercept(_ request: URLRequest) -> URLRequest
}

// AuthenticationAPIInterceptor

final class AuthenticationAPIInterceptor: APIRequestInterceptor {
    private let dataSource: SessionDataSourceProtocol
    
    init(dataSource: SessionDataSourceProtocol = SessionDataSource.shared) {
        self.dataSource = dataSource
    }
    
    func intercept(_ request: URLRequest) -> URLRequest {
        guard let session = dataSource.getSession() else {
            return request
        }
        var copy = request
        copy.setValue("Bearer \(String(decoding: session, as: UTF8.self))", forHTTPHeaderField: "Authorization")
        return copy
    }
}
