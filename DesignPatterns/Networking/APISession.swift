import Foundation

protocol APISessionContract {
    func request<Request: HTTPRequest>(apiRequest: Request, completion: @escaping (Result<Data, Error>) -> Void)
}

struct APISession: APISessionContract {
    static var shared: APISessionContract = APISession()
    
    private let session: URLSession
    private let requestInterceptors: [APIRequestInterceptor]
    
    init(configuration: URLSessionConfiguration = .default,
         requestInterceptors: [APIRequestInterceptor] = [AuthenticationAPIInterceptor()]) {
        self.requestInterceptors = requestInterceptors
        self.session = URLSession(configuration: configuration)
    }
    
    func request<Request: HTTPRequest>(apiRequest: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            var request = try apiRequest.getRequest()
            requestInterceptors.forEach { request = $0.intercept(request) }
            session.dataTask(with: request) { data, response, error in
                if let error {
                    return completion(.failure(error))
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return completion(.failure(APIErrorResponse.network(apiRequest.path)))
                }
                switch httpResponse.statusCode {
                case 200..<300:
                    return completion(.success(data ?? Data()))
                default:
                    return completion(.failure(APIErrorResponse.network(apiRequest.path)))
                }
                
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
}
