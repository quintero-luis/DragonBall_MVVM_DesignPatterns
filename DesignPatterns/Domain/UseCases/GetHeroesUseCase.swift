import Foundation

protocol GetHeroesUseCaseProtocol {
    func run(completion: @escaping (Result<[HeroModel], Error>) -> Void)
}

final class GetHeroesUseCase: GetHeroesUseCaseProtocol {
    func run(completion: @escaping (Result<[HeroModel], Error>) -> Void) {
        GetHeroesAPIRequest()
            .perform { result in
                do {
                    let heroes = try result.get()
                    let mapper = HeroDTOToHeroModelMapper()
                    completion(.success(heroes.map { mapper.map($0) }))
                } catch {
                    completion(.failure(error))
                }
            }
    }
}
