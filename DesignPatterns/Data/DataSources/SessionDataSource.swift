import Foundation

protocol SessionDataSourceProtocol {
    func storeSession(_ session: Data?)
    
    func getSession() -> Data?
}

final class SessionDataSource: SessionDataSourceProtocol {
    static let shared: SessionDataSourceProtocol = SessionDataSource()
    
    private var token: Data?
    
    func storeSession(_ session: Data?) {
        self.token = session
    }
    
    func getSession() -> Data? {
        return self.token
    }
}
