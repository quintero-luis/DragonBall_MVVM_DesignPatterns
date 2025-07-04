//
//  GetHeroDetailAPIRequest.swift
//  DesignPatterns
//
//  Created by Luis Quintero on 22/03/25.
//

import Foundation

struct GetHeroDetailAPIRequest: HTTPRequest {
    // Esperar respuesta de tipo HeroDTO data transfer object
    typealias Response = [HeroDTO]
    
    let method: Methods = .POST
    let path: String = "/api/heros/all"
    let body: (any Encodable)?
    
    init(name: String = "") {
        body = RequestDTO(name: name)
    }
}

private extension GetHeroDetailAPIRequest {
    struct RequestDTO: Codable {
        let name: String
    }
}


