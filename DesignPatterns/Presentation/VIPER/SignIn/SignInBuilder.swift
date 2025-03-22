import UIKit

final class SignInBuilder {
    func build() -> UIViewController {
        let interactor = SignInInteractor()
        let router = SignInRouter()
        let presenter = SignInPresenter(interactor: interactor, router: router)
        let view = SignInViewController(presenter: presenter)
        
        // Set weak references
        interactor.output = presenter
        router.controller = view
        presenter.ui = view
        
        view.modalPresentationStyle = .fullScreen
        
        return view
    }
}
