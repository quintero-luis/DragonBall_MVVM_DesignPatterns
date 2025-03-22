import XCTest

@testable import DesignPatterns


extension HeroModel {
    static let dummyObject = HeroModel(identifier: "1",
                                       name: "Test",
                                       description: "Test",
                                       photo: "Test",
                                       favorite: false)
}

private final class SuccessGetHeroesUseCase: GetHeroesUseCaseProtocol {
    func run(completion: @escaping (Result<[HeroModel], any Error>) -> Void) {
        completion(.success([.dummyObject]))
    }
}

final class HeroesListViewModelTests: XCTestCase {
    func testWhenUseCaseSucceedsStateIsSuccess() {
        let useCase = SuccessGetHeroesUseCase()
        let sut = HeroesListViewModel(useCase: useCase)
        
        let successExpectation = expectation(description: "Success scenario")
        sut.onStateChanged.bind { state in
            if state == .success {
                successExpectation.fulfill()
            }
        }
        
        sut.loadHeroes()
        wait(for: [successExpectation], timeout: 3)
        XCTAssertEqual(sut.heroes, [.dummyObject])
    }
}
