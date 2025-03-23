import Foundation

// Definir los 3 posibles estados de mi vista
// Loading: cuando los datos estan cargando
// Succes: cuando cargan correctamente y Error: Cuando ocurre un error
enum HeroesListState: Equatable {
    case error(reason: String)
    case loading
    case success
}

// Implementa la lógica para recibir los datos del héroe y gestionarlos para la vista
final class HeroesListViewModel {
    // Binding es como hacer que mi vista esté vinculada con los estados de mi ViewModel
    let onStateChanged = Binding<HeroesListState>()
    
    // useCase es el componente que se encarga de obtener los datos (nombre foto y descripción del héroe)
    private let useCase: GetHeroesUseCaseProtocol
    
    // Almacenar los héroes que el ViewModel obtiene, y luego se pasa a la vista
    private(set) var heroes: [HeroModel] = []
    
    init(useCase: GetHeroesUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func loadHeroes() {
        // Indica que la vista debe mostrar el estado de loading, útil para mostrar el activity indicator
        onStateChanged.update(.loading)
        
        // Bloque donde se obtiene la info del héroe
        // useCase.run ejecuta la llamada asíncrona para obtener los datos del héroe desde la API
        useCase.run { [weak self] result in
//            switch result {
//            case .success(let heroes):
//                self?.heroes = heroes
//                self?.onStateChanged.update(.success)
//            case .failure:
//                self?.onStateChanged.update(.error(reason: "Oh no!! no tengo datos!"))
//            }
            
            // Si tiene éxito, guarda los datos del héroe en el ViewModel y actualiza el estado a success
            
            do {
                self?.heroes = try result.get()
                self?.onStateChanged.update(.success)
            } catch {
                self?.onStateChanged.update(.error(reason: "Oh no!! no tengo datos!"))
            }
        }
    }
}
