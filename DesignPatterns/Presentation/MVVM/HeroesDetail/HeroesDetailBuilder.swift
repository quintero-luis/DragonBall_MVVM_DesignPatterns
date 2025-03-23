//
//  HeroesDetailBuilder.swift
//  DesignPatterns
//
//  Created by Luis Quintero on 21/03/25.
//

import UIKit

// Este código esta´encargao de construir la vista del detalle del héroe, debo inizcializar y pasar el ViewModel

final class HeroesDetailBuilder {
    func build(heroName: String) -> UIViewController {
        let useCase = GetHeroesDetailUseCase()
        
        let viewModel = HeroesDetailViewModel(useCase: useCase)
        
        let vc = HeroesDetailViewController(viewModel: viewModel)
        vc.heroName = heroName
        return vc
    }
}

