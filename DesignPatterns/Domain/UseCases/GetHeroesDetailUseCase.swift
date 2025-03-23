//
//  GetHeroesDetailUseCase.swift
//  DesignPatterns
//
//  Created by Luis Quintero on 22/03/25.
//

import Foundation

// Asegurarme que cualquier clase que lo implemente pueda usar el método run()
protocol GetHeroesDetailUseCaseProtocol {
    // run(completion:) toma un callback como parámetro.
    // completion es un callback que devuelve los datos de manera asíncrona y @escaping indica que este callback se ejecutará después de que run() haya terminado.
    
    // Esta funcion es parecida a GetHeroesUseCase, pero queremos solamente un sólo héroe, por lo que usamos HeroModel en vez de [HeroModel], y recibimos heroId
    // Aquí sí debemos poner que recibimos el id explícitamente ya que no recibimos una lista de héroes
    
    func run(heroName: String, completion: @escaping (Result<HeroModel, Error>) -> Void)
    // Result tiene 2 valores, Success y Error
    // Si la API responde correctamente, devuelve un héroe (HeroModel). Si hay un error, devuelve un Error.
}

final class GetHeroesDetailUseCase: GetHeroesDetailUseCaseProtocol {
    func run(heroName: String, completion: @escaping (Result<HeroModel, Error>) -> Void) {
        GetHeroesAPIRequest(name: heroName)
            .perform { result in
                do {
                    let heroDTOs = try result.get()  // Esto es un array [HeroDTO]
                    
                    // Asegurar que el array tiene al menos un elemento
                    guard let heroDTO = heroDTOs.first else {
                        completion(.failure(NSError(domain: "GetHeroesDetailUseCase", code: 404, userInfo: [NSLocalizedDescriptionKey: "Hero not found"])))
                        return
                    }
                    
                    let mapper = HeroDTOToHeroModelMapper()
                    let hero = mapper.map(heroDTO)
                    completion(.success(hero))
                } catch {
                    completion(.failure(error))
                }
            }
    }
}






//final class GetHeroesDetailUseCase: GetHeroesDetailUseCaseProtocol {
//    private let request: GetHeroDetailAPIRequest
//    
//    // Inicializador que recibe el request de la API
//    init(request: GetHeroDetailAPIRequest) {
//        self.request = request
//    }
//    
//    // run() es el Método para obtener datos de la API
//    func run(heroName: String, completion: @escaping (Result<HeroModel, any Error>) -> Void) {
//        // Se crea el request, pasándole el heroId
//        let request = GetHeroDetailAPIRequest(heroName: heroName)
//        
//        print("Request URL: \(request.path)")
//        
//        request.perform { result in
//            switch result {
//            case .success(let heroDTO):
//                // Si la solicitud es exitosa, mapeamos el HeroDTO a HeroModel
//                print("Hero DTO received: \(heroDTO)")
//                let mapper = HeroDTOToHeroModelMapper()
//                let heroModel = mapper.map(heroDTO)
//                print("Mapped Hero: \(heroModel)")
//                
//                completion(.success(heroModel))
//            case .failure(let error):
//                print("Error fetching hero details: \(error)")
//                completion(.failure(error))
//            }
//        }
//    }
//}
