import Foundation

final class SignInInteractor: SignInInteractorInputContract {
    weak var output: SignInInteractorOutputContract?
    private let dataSource: SessionDataSourceProtocol
    
    init(dataSource: SessionDataSourceProtocol = SessionDataSource.shared ) {
        self.dataSource = dataSource
    }
    
    func signIn(username: String, password: String) {
        guard isValidUsername(username) else {
            output?.onLoginPerformed(result: .failure(LoginError(reason: "El usuario no es válido")))
            return
        }
        guard isValidPassword(password) else {
            output?.onLoginPerformed(result: .failure(LoginError(reason: "La contraseña no es válida")))
            return
        }
        
        LoginAPIRequest(username: username, password: password)
            .perform { [weak self] response in
                DispatchQueue.main.async {
                    switch response {
                    case .success(let data):
                        self?.dataSource.storeSession(data)
                        self?.output?.onLoginPerformed(result: .success(()))
                    case .failure:
                        self?.output?.onLoginPerformed(result: .failure(LoginError(reason: "Ha ocurrido un error en la red")))
                    }
                }
            }
    }
    
    private func isValidUsername(_ string: String) -> Bool {
        !string.isEmpty && string.contains("@")
    }

    private func isValidPassword(_ string: String) -> Bool {
        string.count >= 4
    }
}
