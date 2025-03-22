import UIKit

final class LoginBuilder {
    func build() -> UIViewController {
        let useCase = LoginUseCase(dataSource: SessionDataSource.shared)
        let viewModel = LoginViewModel(useCase: useCase)
        let controller = LoginViewController(viewModel: viewModel)
        controller.modalPresentationStyle = .fullScreen
        return controller
    }
}
