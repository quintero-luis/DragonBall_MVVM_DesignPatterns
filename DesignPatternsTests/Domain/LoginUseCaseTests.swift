import XCTest

@testable import DesignPatterns

final class APISessionMock: APISessionContract {
    let mockResponse: ((any HTTPRequest) -> Result<Data, any Error>)
    
    init(mockResponse: @escaping (any HTTPRequest) -> Result<Data, any Error>) {
        self.mockResponse = mockResponse
    }
    
    func request<Request: HTTPRequest>(apiRequest: Request, completion: @escaping (Result<Data, any Error>) -> Void) {
        completion(mockResponse(apiRequest))
    }
}

private final class SessionDataSourceMock: SessionDataSourceProtocol {
    private(set) var session: Data?
        
    func storeSession(_ session: Data?) {
        self.session = session
    }
    
    func getSession() -> Data? { nil }
}

final class LoginUseCaseTests: XCTestCase {
    func testSuccessStoresToken() {
        let dataSource = SessionDataSourceMock()
        let sut = LoginUseCase(dataSource: dataSource)
        let successExpectation = expectation(description: "Success")
        APISession.shared = APISessionMock { _ in .success(Data("HelloWorld".utf8)) }
        
        sut.run(username: "hello@hello", password: "12345") { result in
            if case .success = result {
                successExpectation.fulfill()
            }
        }
        wait(for: [successExpectation], timeout: 5)
        XCTAssertNotNil(dataSource.session)
    }
}
