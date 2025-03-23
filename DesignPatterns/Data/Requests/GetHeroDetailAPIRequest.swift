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



//struct GetHeroDetailAPIRequest: HTTPRequest {
//    // Esperar respuesta de tipo HeroDTO data transfer object
//    typealias Response = HeroDTO
//    
//    // Usamos GET como método porque queremos obtener algo
//    var method: Methods = .GET
//    
//    // Path que será determinado dinámicanmente con el heroId
//    var path: String = "/api/heros/name"
//    
//    init(heroName: String = "") {
//        print("id")
//        self.path = "/api/heros/\(heroName)"
//        print("Request path created: \(self.path)")
//    }
//}

// Este APIRequest tiene la estructura que maneja la solicitud HTTPpara obtener los detalles de un sólo héroe
//struct GetHeroDetailAPIRequest: HTTPRequest {
//    // Esperar respuesta de tipo HeroDTO data transfer object
//    typealias Response = HeroDTO
//    
//    // Usamos GET como método porque queremos obtener algo
//    var method: Methods = .GET
//    
//    // Path que será determinado dinámicanmente con el heroId
//    var path: String = "/api/heros/id"
//    
//    init(heroId: String = "") {
//        print("id")
//        self.path = "/api/heros/\(heroId)"
//    }
//}

