import UIKit

protocol SignInPresenterContract: AnyObject {
    func onSignInButtonTapped(username: String?, password: String?)
}

protocol SignInViewContract: AnyObject {
    func startLoading()
    func stopLoading()
    func showError(reason: String)
}

protocol SignInInteractorInputContract: AnyObject {
    func signIn(username: String, password: String)
}

protocol SignInInteractorOutputContract: AnyObject {
    func onLoginPerformed(result: Result<Void, LoginError>)
}

protocol SignInRouterContract: AnyObject {
    func goToHomeView()
}
