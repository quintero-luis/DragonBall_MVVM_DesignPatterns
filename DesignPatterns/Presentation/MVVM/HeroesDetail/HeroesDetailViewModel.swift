//
//  HeroesDetailViewModel.swift
//  DesignPatterns
//
//  Created by Luis Quintero on 21/03/25.
//

import Foundation

// Definir los estados posibles
enum HeroesDetailState: Equatable {
    case loading
    case success(hero: HeroModel)
    case error(error: String)
}

// Implementa la lógica para recibir los datos del héroe y gestionarlos para la vista
final class HeroesDetailViewModel {
    // Vincular mi vista a los estados del viewModel con Binding
    let onStateChanged = Binding<HeroesDetailState>()
    
    // Obtener los datos del héroe
    private let useCase: GetHeroesDetailUseCaseProtocol
    
    // Almacenar héroes que este ViewModelObtiene
    private(set) var heroDetail: HeroModel?
    
    // ?
    init(useCase: GetHeroesDetailUseCaseProtocol) {
        self.useCase = useCase
    }
    func loadHeroDetail(heroName: String) {
        onStateChanged.update(.loading)
        useCase.run(heroName: heroName) { [weak self] result in
            do {
                let hero = try result.get()
                self?.heroDetail = hero
                self?.onStateChanged.update(.success(hero: hero))
            } catch {
                self?.onStateChanged.update(.error(error: "Oh no, no tengo los detalles del héroe"))
            }
        }
    }
}
