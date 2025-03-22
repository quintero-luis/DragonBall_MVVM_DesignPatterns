import Foundation

final class HomeInteractor: HomeInteractorInputContract {
    weak var output: HomeInteractorOutputContract?
    
    func loadHeroes() {
        GetHeroesAPIRequest()
            .perform { [weak self] result in
                do {
                    let mapper = HeroDTOToHeroModelMapper()
                    let dtoArray = try result.get()
                    let heroesArray = dtoArray.map { mapper.map($0) }
                    DispatchQueue.main.async {
                        self?.output?.onHeroesFinished(.success(heroesArray))
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        self?.output?.onHeroesFinished(.failure(error))
                    }
                }
            }
    }
}
