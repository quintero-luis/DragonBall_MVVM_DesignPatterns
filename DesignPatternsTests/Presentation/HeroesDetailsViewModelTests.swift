import XCTest
@testable import DesignPatterns
// Mock que simula un success al inentar obtener los detalles de uin héroe
private final class SuccessGetHeroesDetailUseCase: GetHeroesDetailUseCaseProtocol {
    func run(heroName: String, completion: @escaping (Result<HeroModel, any Error>) -> Void) {
        completion(.success(HeroModel.dummyObject)) // Retorna un héroe simulado
    }
}
// Mock que simunla un fallo al inentar obtener los detalles de uin héroe
private final class FailureGetHeroesDetailUseCase: GetHeroesDetailUseCaseProtocol {
    func run(heroName: String, completion: @escaping (Result<HeroModel, any Error>) -> Void) {
        // Simula un error cuando el héroe no se encuentra
        completion(.failure(NSError(domain: "com.example", code: 1, userInfo: [NSLocalizedDescriptionKey: "Hero not found"])))
    }
}

final class HeroesDetailViewModelTests: XCTestCase {
    
    func testWhenGetHeroesDetailSucceedsStateIsSuccess() {
        let useCase = SuccessGetHeroesDetailUseCase()
        let sut = HeroesDetailViewModel(useCase: useCase)
        
        let successExpectation = expectation(description: "Success scenario")
        
        sut.onStateChanged.bind { state in
            if case .success(let hero) = state {
                XCTAssertEqual(hero.name, "Test")  // Verificar que el héroe cargado sea el esperado
                successExpectation.fulfill()
            }
        }
        
        sut.loadHeroDetail(heroName: "TestHero")
        
        wait(for: [successExpectation], timeout: 3)
    }
    
    func testWhenGetHeroesDetailFailsStateIsError() {
        // Mock de un caso de uso que devuelve un error
        let useCase = FailureGetHeroesDetailUseCase() // Ahora estamos usando el mock de fallo
        let sut = HeroesDetailViewModel(useCase: useCase)
        
        let errorExpectation = expectation(description: "Error scenario")
        
        sut.onStateChanged.bind { state in
            if case .error = state {
                errorExpectation.fulfill()  // Verifica que se haya manejado el error
            }
        }
        
        sut.loadHeroDetail(heroName: "InvalidHero") // Simula la carga de un héroe que no existe
        
        wait(for: [errorExpectation], timeout: 3)
    }
}
