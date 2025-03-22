import Foundation

protocol HTTPRequest {
    associatedtype Response: Decodable
    
    typealias APIRequestResponse = Result<Response, APIErrorResponse>
    typealias APIRequestCompletion = (APIRequestResponse) -> Void
    
    var method: Methods { get }
    var host: String { get }
    var path: String { get }
    var queryParameters: [String: String] { get }
    var headers: [String: String] { get }
    var body: Encodable? { get }
}

extension HTTPRequest {
    var host: String { "dragonball.keepcoding.education" }
    var queryParameters: [String: String] { [:] }
    var headers: [String: String] { [:] }
    var body: Encodable? { nil }
    
    func getRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        if !queryParameters.isEmpty {
            components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard let url = components.url else {
            fatalError("Invalid URLComponents")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body, method != .GET {
            request.httpBody = try JSONEncoder().encode(body)
        }
        request.timeoutInterval = 30
        request.allHTTPHeaderFields = ["Accept": "application/json", "Content-Type": "application/json"]
            .merging(headers) { $1 }
        return request
    }
    
    func perform(session: APISessionContract = APISession.shared, completion: @escaping APIRequestCompletion) {
        session.request(apiRequest: self) { result in
            do {
                let data = try result.get()
                if Response.self == Void.self {
                    return completion(.success(() as! Response))
                } else if Response.self == Data.self {
                    return completion(.success(data as! Response))
                }
                return try completion(.success(JSONDecoder().decode(Response.self, from: data)))
            } catch let error as APIErrorResponse {
                completion(.failure(error))
            } catch let error as DecodingError {
                completion(.failure(APIErrorResponse.parseData(path)))
            } catch {
                completion(.failure(APIErrorResponse.unknown(path)))
            }
        }
    }
}
