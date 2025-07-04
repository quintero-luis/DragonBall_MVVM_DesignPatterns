import UIKit

final class HeroCell: UITableViewCell {
    static let reuseIdentifier = "HeroCell"
    static let height: CGFloat = 90
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarView: AsyncImage!
    
    func setData(name: String, photo: String) {
        nameLabel.text = name
        avatarView.setImage(photo)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCardStyle()
    }
    
    private func setupCardStyle() {
        contentView.backgroundColor = .clear // So the shadow can be visible
        
        // Create a view container to apply shadow and corner radius
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.15
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowRadius = 8
        cardView.layer.masksToBounds = false
        
        cardView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.insertSubview(cardView, at: 0)
        
    }
}
