import XCTest

@testable import DesignPatterns


final class SuccessLoginUseCase: LoginUseCaseProtocol {
    func run(username: String, password: String, completion: @escaping (Result<Void, LoginError>) -> Void) {
        completion(.success(()))
    }
}

final class FailedLoginUseCase: LoginUseCaseProtocol {
    func run(username: String, password: String, completion: @escaping (Result<Void, LoginError>) -> Void) {
        completion(.failure(LoginError(reason: "Hello world!")))
    }
}

final class LoginViewModelTests: XCTestCase {
    func testWhenUseCaseSucceedsStateIsSuccess() {
        let useCase = SuccessLoginUseCase()
        let sut = LoginViewModel(useCase: useCase)
        
        let loadingExpectation = expectation(description: "View is loading")
        let successExpectation = expectation(description: "View has succeed")
    
        sut.onStateChanged.bind { state in
            if state == .loading {
                loadingExpectation.fulfill()
            } else if state == .success {
                successExpectation.fulfill()
            }
        }
        
        sut.login(username: "", password: "")
        wait(for: [loadingExpectation, successExpectation], timeout: 5)
    }
    
    func testWhenUseCaseFailsStateIsError() {
        let useCase = FailedLoginUseCase()
        let sut = LoginViewModel(useCase: useCase)
        
        let expectedText = "Hello world!"
        let loadingExpectation = expectation(description: "View is loading")
        let failureExpectation = expectation(description: "View has failed")
    
        sut.onStateChanged.bind { state in
            switch state {
            case .loading: loadingExpectation.fulfill()
            case .error(let reason):
                XCTAssertEqual(reason, expectedText)
                failureExpectation.fulfill()
            default: break
            }
        }
        sut.login(username: "", password: "")
        wait(for: [loadingExpectation, failureExpectation], timeout: 5)
    }
}
