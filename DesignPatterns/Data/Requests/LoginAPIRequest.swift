import Foundation

struct LoginAPIRequest: HTTPRequest {
    typealias Response = Data
    
    let headers: [String: String]
    let method: Methods = .POST
    let path: String = "/api/auth/login"
    
    init(username: String, password: String) {
        let loginData = Data(String(format: "%@:%@", username, password).utf8)
        let base64LoginData = loginData.base64EncodedString()
        headers = ["Authorization": "Basic \(base64LoginData)"]
    }
}
