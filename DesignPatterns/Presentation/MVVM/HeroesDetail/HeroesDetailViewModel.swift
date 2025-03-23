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
    // MARK: - Modificar useCase.run para recibir un heroId y devolver un solo HeroModel.
    // MARK: - Error en el Enum HeroesDetailState
    
    //Problema: .success no está almacenando el héroe obtenido.

    //Solución: Cambiar .success para incluir HeroModel.
//    func loadHeroDetail(heroId: String) {
//        // Pone el estado en loading, para mostrar el activity indicator
//        onStateChanged.update(.loading)
//        // Obtener la info del héroe por medio del useCase.run
//        // Eejecutar llamada asíncrona para obtener datos del héroe
//        useCase.run(heroId: heroId) { [weak self] result in
//            
//            // 2 estados posibles succes y error
//            
//            //result es un objeto de tipo Result<[HeroModel], Error>, que puede contener un éxito con una lista de héroes ([HeroModel]) o un error lo que hacemos con el .get() es intentar obtener el valor exitoso (success) la lista de héroes
//            // Si no es exitoso se va al catch para cachar el error :)
//            switch result {
//            case .success(let hero):
//                self?.heroDetail = hero
//                self?.onStateChanged.update(.success(hero: hero))
//            case .failure:
//                self?.onStateChanged.update(.error(error: "Oh no, no tengo los detalles del héroe"))
//            }
//        }
//    }
    
    
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
