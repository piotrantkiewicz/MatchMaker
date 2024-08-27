import UIKit
import SnapKit
import DesignSystem

class MatchCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let overlayView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.layer.cornerRadius = 30
        contentView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(overlayView)
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.6, 1.0]
        gradientLayer.frame = overlayView.bounds
        overlayView.layer.addSublayer(gradientLayer)
        
        contentView.addSubview(nameLabel)
        nameLabel.font = .cardDetailTitle
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.bottom.trailing.equalToSuperview().inset(14)
        }
    }
    
    func configure(with user: User) {
        nameLabel.text = user.name
        imageView.sd_setImage(with: user.imageURL, completed: nil)
    }
}







