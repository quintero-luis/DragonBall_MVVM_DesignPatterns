import Foundation

enum HeroesListState: Equatable {
    case error(reason: String)
    case loading
    case success
}

final class HeroesListViewModel {
    let onStateChanged = Binding<HeroesListState>()
    private let useCase: GetHeroesUseCaseProtocol
    private(set) var heroes: [HeroModel] = []
    
    init(useCase: GetHeroesUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func loadHeroes() {
        onStateChanged.update(.loading)
        useCase.run { [weak self] result in
//            switch result {
//            case .success(let heroes):
//                self?.heroes = heroes
//                self?.onStateChanged.update(.success)
//            case .failure:
//                self?.onStateChanged.update(.error(reason: "Oh no!! no tengo datos!"))
//            }
            do {
                self?.heroes = try result.get()
                self?.onStateChanged.update(.success)
            } catch {
                self?.onStateChanged.update(.error(reason: "Oh no!! no tengo datos!"))
            }
        }
    }
}
