import UIKit

final class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel
    
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var loginButton: UIButton!
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LoginView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Binding
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        viewModel.onStateChanged.bind { [weak self] state in
            switch state {
            case .error(let reason): self?.renderError(reason)
            case .loading: self?.renderLoading()
            case .success: self?.renderSuccess()
            }
        }
    }
    
    // MARK: - Events
    @IBAction func onButtonTapped(_ sender: Any) {
        viewModel.login(username: usernameField.text, password: passwordField.text)
    }
    
    // MARK: - State management
    private func renderSuccess() {
        activityIndicator.stopAnimating()
        loginButton.isHidden = false
        errorLabel.isHidden = true
        present(HeroesListBuilder().build(), animated: true)
    }
    
    private func renderLoading() {
        activityIndicator.startAnimating()
        loginButton.isHidden = true
        errorLabel.isHidden = true
    }
    
    private func renderError(_ message: String) {
        activityIndicator.stopAnimating()
        loginButton.isHidden = false
        errorLabel.text = message
        errorLabel.isHidden = false
    }
}

//#Preview {
//    LoginBuilder().build()
//}
