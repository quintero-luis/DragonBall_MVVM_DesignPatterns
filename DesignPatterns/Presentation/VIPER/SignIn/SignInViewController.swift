import UIKit

final class SignInViewController: UIViewController, SignInViewContract {
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var loginButton: UIButton!
    private let presenter: SignInPresenterContract
    
    init(presenter: SignInPresenterContract) {
        self.presenter = presenter
        super.init(nibName: "SignInView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func onSignInButtonTapped(_ sender: Any) {
        presenter.onSignInButtonTapped(username: usernameField.text, password: passwordField.text)
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        errorLabel.isHidden = true
        loginButton.isHidden = true
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = true
        loginButton.isHidden = false
    }
    
    func showError(reason: String) {
        activityIndicator.stopAnimating()
        errorLabel.text = reason
        errorLabel.isHidden = false
        loginButton.isHidden = false
    }
}
