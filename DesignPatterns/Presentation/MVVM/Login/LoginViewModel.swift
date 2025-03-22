import Foundation

enum LoginState: Equatable {
    case success
    case loading
    case error(reason: String)
}

final class LoginViewModel {
    let useCase: LoginUseCaseProtocol
    let onStateChanged = Binding<LoginState>()
    
    init(useCase: LoginUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func login(username: String?, password: String?) {
        onStateChanged.update(.loading)
        useCase.run(username: username ?? "", password: password ?? "") { [weak self] result in
            switch result {
            case .success:
                self?.onStateChanged.update(.success)
            case .failure(let error):
                self?.onStateChanged.update(.error(reason: error.reason))
            }
        }
    }
}
