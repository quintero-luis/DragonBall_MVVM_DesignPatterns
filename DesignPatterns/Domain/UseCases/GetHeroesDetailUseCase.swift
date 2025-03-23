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
    private let request: GetHeroDetailAPIRequest
    
    // Inicializador que recibe el request de la API
    init(request: GetHeroDetailAPIRequest) {
        self.request = request
    }
    
    // run() es el Método para obtener datos de la API
    func run(heroName: String, completion: @escaping (Result<HeroModel, any Error>) -> Void) {
        // Se crea el request, pasándole el heroId
        let request = GetHeroDetailAPIRequest(heroName: heroName)
        request.perform { result in
            switch result {
            case .success(let heroDTO):
                // Si la solicitud es exitosa, mapeamos el HeroDTO a HeroModel
                let mapper = HeroDTOToHeroModelMapper()
                let heroModel = mapper.map(heroDTO)
                
                completion(.success(heroModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
