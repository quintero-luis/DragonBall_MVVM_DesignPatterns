import XCTest
@testable import DesignPatterns

// Simulación de un caso exitoso para el GetHeroesDetailUseCase
private final class SuccessGetHeroesDetailUseCase: GetHeroesDetailUseCaseProtocol {
    func run(heroName: String, completion: @escaping (Result<HeroModel, any Error>) -> Void) {
        // Simulamos un resultado exitoso
        completion(.success(HeroModel.dummyObject))
    }
}

// Simulación de un caso de error para el GetHeroesDetailUseCase
private final class FailureGetHeroesDetailUseCase: GetHeroesDetailUseCaseProtocol {
    func run(heroName: String, completion: @escaping (Result<HeroModel, any Error>) -> Void) {
        // Simulamos un error
        completion(.failure(NSError(domain: "com.example", code: 1, userInfo: [NSLocalizedDescriptionKey: "Hero not found"])))
    }
}

final class GetHeroesDetailUseCaseTests: XCTestCase {
    
    func testWhenGetHeroesDetailSucceeds() {
        // Usamos la clase simulada de éxito para el request
        let useCase = SuccessGetHeroesDetailUseCase()
        
        let successExpectation = expectation(description: "Success scenario")
        
        useCase.run(heroName: "TestHero") { result in
            if case .success(let hero) = result {
                XCTAssertEqual(hero.name, "Test")  // Verificar que el nombre sea el esperado
                successExpectation.fulfill()
            }
        }
        
        wait(for: [successExpectation], timeout: 3)
    }
    
    func testWhenGetHeroesDetailFails() {
        // Usamos la clase simulada de error para el request
        let useCase = FailureGetHeroesDetailUseCase()
        
        let errorExpectation = expectation(description: "Error scenario")
        
        useCase.run(heroName: "InvalidHero") { result in
            if case .failure(let error) = result {
                XCTAssertEqual((error as NSError).localizedDescription, "Hero not found")  // Verificar el mensaje de error
                errorExpectation.fulfill()
            }
        }
        
        wait(for: [errorExpectation], timeout: 3)
    }
}

