import UIKit

final class HomeRouter: HomeRouterContract {
    weak var controller: UIViewController?
    
    func goToDetail(_ name: String) {
        controller?.navigationController?.pushViewController(UIViewController(), animated: true)
    }
}
