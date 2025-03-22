import Foundation

final class HomePresenter: HomePresenterContract, HomeInteractorOutputContract {
    weak var ui: HomeViewContract?
    private let router: HomeRouterContract
    private let interactor: HomeInteractorInputContract
    private(set) var heroes: [HeroModel] = []
    
    init(interactor: HomeInteractorInputContract, router: HomeRouterContract) {
        self.router = router
        self.interactor = interactor
    }
    
    func loadHeroes() {
        ui?.startLoading()
        interactor.loadHeroes()
    }
    
    func onHeroesFinished(_ result: Result<[HeroModel], any Error>) {
        switch result {
        case .success(let heroes): onSuccess(heroes)
        case .failure(let error): onError(error)
        }
    }
    
    func onHeroTapped(_ position: Int) {
        router.goToDetail(heroes[position].name)
    }
    
    private func onError(_ error: Error) {
        ui?.stopLoading()
        ui?.showError(error.localizedDescription)
    }
    
    private func onSuccess(_ heroes: [HeroModel]) {
        self.heroes = heroes
        ui?.stopLoading()
        ui?.updateView()
    }
}
