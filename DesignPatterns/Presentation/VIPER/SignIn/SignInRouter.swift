import UIKit

final class SignInRouter: SignInRouterContract {
    weak var controller: UIViewController?
    
    func goToHomeView() {
        controller?.present(HomeBuilder().build(), animated: true)
    }
}
