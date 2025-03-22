import Foundation

enum SplashState: Equatable {
    case loading
    
    case error
    
    case ready
}

final class SplashViewModel {
    var onStateChanged = Binding<SplashState>()
    
    func load() {
        onStateChanged.update(.loading)
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.onStateChanged.update(.ready)
        }
    }
}

