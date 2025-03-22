import UIKit

final class HeroCell: UITableViewCell {
    static let reuseIdentifier = "HeroCell"
    static let height: CGFloat = 90
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarView: AsyncImage!
    
    func setData(name: String, photo: String) {
        nameLabel.text = name
        avatarView.setImage(photo)
    }
}
