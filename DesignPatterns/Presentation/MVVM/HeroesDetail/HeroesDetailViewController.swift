//
//  HeroesDetailViewController.swift
//  DesignPatterns
//
//  Created by Luis Quintero on 21/03/25.
//

import UIKit

class HeroesDetailViewController: UIViewController {
    @IBOutlet weak var stackDetail: UIStackView!
    
    @IBOutlet weak var imageViewDetail: AsyncImage!
    
    @IBOutlet weak var nameLabelDetail: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    private let viewModel: HeroesDetailViewModel
        
        var heroName: String = ""
        
        init(viewModel: HeroesDetailViewModel) {
            self.viewModel = viewModel
            super.init(nibName: "HeroesDetailView", bundle: Bundle(for: type(of: self)))
        }
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // luisgqr1975@gmail.com
        override func viewDidLoad() {
            super.viewDidLoad()
            print("HeroesDetailViewController loaded")
            bind()
             //Cargar los detalles del héroe con el ID correspondiente
            if let heroName = viewModel.heroDetail?.name {
                print("Loading hero details for heroId: \(heroName)")
                viewModel.loadHeroDetail(heroName: heroName)
                    } else {
                        print("No heroId found in viewModel")
                    }
            viewModel.loadHeroDetail(heroName: heroName)
            print("sggsg")
        }
        
        private func bind() {
            viewModel.onStateChanged.bind { [weak self] state in
                switch state {
                case .error(let error):
                    self?.renderError(error)
                case .loading: self?.renderLoading()
                case .success(let hero): self?.renderSuccess(hero)
                }
            }
        }
        
        private func renderSuccess(_ hero: HeroModel) {
    //         Asignar los datos del héroe a los elementos de la vista
            nameLabelDetail.text = hero.name
            descriptionTextView.text = hero.description
            imageViewDetail.setImage(hero.photo)
        }
        
        private func renderError(_ message: String) {
                // Mostrar el error en la vista, por ejemplo con un alerta
    //            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    //            alert.addAction(UIAlertAction(title: "OK", style: .default))
    //            present(alert, animated: true)
            }

            private func renderLoading() {
                // Mostrar actividad de carga (puedes usar un UIActivityIndicator)
    //            print("Loading...")
    //            activityIndicatorDetail.startAnimating()
                
            }
    }
