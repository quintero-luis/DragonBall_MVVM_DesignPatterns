import UIKit

final class AsyncImage: UIImageView {
    var currentWorkItem: DispatchWorkItem?
    
    func setImage(_ image: String) {
        if let url = URL(string: image) {
            self.setImage(url)
        }
    }
    
    func setImage(_ image: URL) {
        cancel()
        self.image = UIImage()
        let workItem = DispatchWorkItem {
            let image = (try? Data(contentsOf: image)).flatMap { UIImage(data: $0) }
            DispatchQueue.main.async { [weak self] in
                self?.image = image ?? UIImage()
                self?.currentWorkItem = nil
            }
        }
        DispatchQueue.global().async(execute: workItem)
        currentWorkItem = workItem
    }
    
    func cancel() {
        currentWorkItem?.cancel()
        currentWorkItem = nil
    }
}
