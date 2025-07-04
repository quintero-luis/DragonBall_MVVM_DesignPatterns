//
//  HeroesListViewController.swift
//  DesignPatterns
//
//  Created by Alberto García-Muñoz on 19/3/25.
//

import UIKit

class HeroesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var errorStackView: UIStackView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel: HeroesListViewModel
        
        init(viewModel: HeroesListViewModel) {
            self.viewModel = viewModel
            super.init(nibName: "HeroesListView", bundle: Bundle(for: type(of: self)))
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            bind()
            viewModel.loadHeroes()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "HeroCell", bundle: Bundle(for: type(of: self))),
                               forCellReuseIdentifier: HeroCell.reuseIdentifier)
        }
    
    @IBAction func onRetryButtonTapped(_ sender: Any) {
        viewModel.loadHeroes()
    }
    
    // MARK: - Binding
        private func bind() {
            viewModel.onStateChanged.bind { [weak self] state in
                switch state {
                case .error(let reason):
                    self?.renderError(reason)
                case .loading:
                    self?.renderLoading()
                case .success:
                    self?.renderSuccess()
                }
            }
        }
        
        // MARK: - State rendering
        private func renderError(_ reason: String) {
            errorLabel.text = reason
            errorStackView.isHidden = false
            activityIndicator.stopAnimating()
        }
        
        private func renderLoading() {
            errorStackView.isHidden = true
            activityIndicator.startAnimating()
        }
        
        private func renderSuccess() {
            errorStackView.isHidden = true
            activityIndicator.stopAnimating()
            tableView.reloadData()
        }
        
        // MARK: - UITableViewDataSource conformance
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            viewModel.heroes.count
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            HeroCell.height
            return 132
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeroCell.reuseIdentifier)
            if let cell = cell as? HeroCell {
                let hero = viewModel.heroes[indexPath.row]
                cell.setData(name: hero.name, photo: hero.photo)
            }
            return cell ?? UITableViewCell()
        }
        
        // MARK: - UITableViewDelegate
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Navega a algún lado
            let selectedHero = viewModel.heroes[indexPath.row]
            
            navigateToDetail(hero: selectedHero)
            // Crear el builder para la vista de detalles del héroe
            
            print("XD Detail view controller")
            // Navegar al detalle del héroe
    //        navigationController?.pushViewController(detailViewController, animated: true)
    //        show(detailViewController, sender: self)
        }
        
        private func navigateToDetail(hero: HeroModel) {
            let heroesDetailBuilder = HeroesDetailBuilder()
            let detailViewController = heroesDetailBuilder.build(heroName: hero.name)
            show(detailViewController, sender: self)
        }
    }
