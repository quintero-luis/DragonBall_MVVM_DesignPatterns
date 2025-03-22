import UIKit

class HomeViewController: UIViewController, HomeViewContract, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private weak var errorContainerView: UIStackView!
    @IBOutlet private weak var activityView: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var errorLabel: UILabel!
    private let presenter: HomePresenterContract
    
    init(presenter: HomePresenterContract) {
        self.presenter = presenter
        super.init(nibName: "HomeView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadHeroes()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HeroCell", bundle: Bundle(for: HeroCell.self)),
                           forCellReuseIdentifier: HeroCell.reuseIdentifier)
    }
    
    func startLoading() {
        errorContainerView.isHidden = true
        tableView.isHidden = true
        activityView.startAnimating()
    }
    
    func stopLoading() {
        activityView.stopAnimating()
    }
    
    func showError(_ reason: String) {
        errorLabel.text = reason
        errorContainerView.isHidden = false
    }
    
    func updateView() {
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.heroes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        HeroCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroCell.reuseIdentifier)
        
        if let cell = cell as? HeroCell {
            let hero = presenter.heroes[indexPath.row]
            cell.setData(name: hero.name, photo: hero.photo)
        }
        
        return cell ?? UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onHeroTapped(indexPath.row)
    }
}
