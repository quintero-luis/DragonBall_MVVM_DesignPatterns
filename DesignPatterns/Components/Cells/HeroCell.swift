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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCardStyle()
    }
    
    private func setupCardStyle() {
        contentView.backgroundColor = .clear // So the shadow can be visible
        
        // Create a view container to apply shadow and corner radius
        let backgroundCardView = UIView(frame: contentView.bounds)
        backgroundCardView.backgroundColor = .white
        backgroundCardView.layer.cornerRadius = 12
        backgroundCardView.layer.shadowColor = UIColor.black.cgColor
        backgroundCardView.layer.shadowOpacity = 0.15
        backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        backgroundCardView.layer.shadowRadius = 8
        backgroundCardView.layer.masksToBounds = false
        
        backgroundCardView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.insertSubview(backgroundCardView, at: 0)
        
    }
}
