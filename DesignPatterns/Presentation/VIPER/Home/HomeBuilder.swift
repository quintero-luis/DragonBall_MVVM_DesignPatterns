import UIKit

final class HomeBuilder {
    func build() -> UIViewController {
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interactor: interactor, router: router)
        let view = HomeViewController(presenter: presenter)
        
        // Set weak references
        interactor.output = presenter
        router.controller = view
        presenter.ui = view
        
        let controller = UINavigationController(rootViewController: view)
        controller.modalPresentationStyle = .fullScreen
        
        return controller
    }
}
