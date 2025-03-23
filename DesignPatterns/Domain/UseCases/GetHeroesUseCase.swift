import Foundation

protocol GetHeroesUseCaseProtocol {
    func run(completion: @escaping (Result<[HeroModel], Error>) -> Void)
}

final class GetHeroesUseCase: GetHeroesUseCaseProtocol {
    func run(completion: @escaping (Result<[HeroModel], Error>) -> Void) {
        GetHeroesAPIRequest()
        // .perform { result in ... } ejecuta la petición de red y obtiene un Result<Data, Error>.
            .perform { result in
                do {
                    // result.get() intenta extraer los datos (Data).
                    let heroes = try result.get()
                    let mapper = HeroDTOToHeroModelMapper()
                    completion(.success(heroes.map { mapper.map($0) }))
                } catch {
                    completion(.failure(error))
                }
            }
    }
}
