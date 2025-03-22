protocol HomeViewContract: AnyObject {
    func startLoading()
    func stopLoading()
    func showError(_ reason: String)
    func updateView()
}

protocol HomePresenterContract: AnyObject {
    var heroes: [HeroModel] { get }
    
    func loadHeroes()
    func onHeroTapped(_ position: Int)
}

protocol HomeRouterContract: AnyObject {
    func goToDetail(_ name: String)
}

protocol HomeInteractorInputContract: AnyObject {
    func loadHeroes()
}

protocol HomeInteractorOutputContract: AnyObject {
    func onHeroesFinished(_ result: Result<[HeroModel], Error>)
}
