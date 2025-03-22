import Foundation

struct GetHeroesAPIRequest: HTTPRequest {
    typealias Response = [HeroDTO]
    
    let method: Methods = .POST
    let path: String = "/api/heros/all"
    let body: (any Encodable)?
    
    init(name: String = "") {
        body = RequestDTO(name: name)
    }
}

private extension GetHeroesAPIRequest {
    struct RequestDTO: Codable {
        let name: String
    }
}
