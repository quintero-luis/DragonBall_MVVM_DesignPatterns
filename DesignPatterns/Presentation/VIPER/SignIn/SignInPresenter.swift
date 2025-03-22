import Foundation

final class SignInPresenter: SignInPresenterContract, SignInInteractorOutputContract {
    private let interactor: SignInInteractorInputContract
    private let router: SignInRouterContract
    weak var ui: SignInViewContract?
    
    init(interactor: SignInInteractorInputContract, router: SignInRouterContract) {
        self.interactor = interactor
        self.router = router
    }
    
    func onSignInButtonTapped(username: String?, password: String?) {
        ui?.startLoading()
        interactor.signIn(username: username ?? "", password: password ?? "")
    }
    
    func onLoginPerformed(result: Result<Void, LoginError>) {
        switch result {
        case .success: onLoginSucceed()
        case .failure(let error): onLoginFailed(error.reason)
        }
    }
    
    // success scenario
    private func onLoginSucceed() {
        ui?.stopLoading()
        router.goToHomeView()
    }
    
    // Fail scenario
    private func onLoginFailed(_ reason: String) {
        ui?.stopLoading()
        ui?.showError(reason: reason)
    }
}
