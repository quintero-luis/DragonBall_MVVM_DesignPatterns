import XCTest

@testable import DesignPatterns

final class HomeInteractorMock: HomeInteractorInputContract {
    var loadHeroesCalled = false
    
    func loadHeroes() {
        loadHeroesCalled.toggle()
    }
}

final class HomeViewMock: HomeViewContract {
    var startLoadingCalled = false
    var stopLoadingCalled = false
    var reasonPassed: String?
    var updateViewCalled = false
    
    func startLoading() {
        startLoadingCalled = true
    }
    
    func stopLoading() {
        stopLoadingCalled = true
    }
    
    func showError(_ reason: String) {
        reasonPassed = reason
    }
    
    func updateView() {
        updateViewCalled = true
    }
}


final class HomePresenterTests: XCTestCase {
    func testWhenInteractorSucceedsViewIsUpdated() {
        let interactorMock = HomeInteractorMock()
        let viewMock = HomeViewMock()
        let sut = HomePresenter(interactor: interactorMock, router: HomeRouter())
        sut.ui = viewMock
        sut.loadHeroes()
        XCTAssertTrue(interactorMock.loadHeroesCalled)
        XCTAssertTrue(viewMock.startLoadingCalled)
        sut.onHeroesFinished(.success([.dummyObject]))
        XCTAssertTrue(viewMock.stopLoadingCalled)
        XCTAssertTrue(viewMock.updateViewCalled)
        XCTAssertEqual(sut.heroes, [.dummyObject])
    }
}
