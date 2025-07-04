import UIKit

final class HeroesListBuilder {
    func build() -> UIViewController {
        let useCase = GetHeroesUseCase()
        
        let viewModel = HeroesListViewModel(useCase: useCase)
        
        let rootViewController = HeroesListViewController(viewModel: viewModel)
        
        
        return rootViewController
    }
}
