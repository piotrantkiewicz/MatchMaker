import UIKit
import SnapKit

class ProfilePictureCell: UITableViewCell {
    
    private var profileImageView: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func configure(with image: UIImage) {
        profileImageView.image = image
    }
    
    private func commonInit() {
        setupUI()
    }
}

extension ProfilePictureCell {
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        setupImageView()
    }
    
    private func setupImageView() {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .profilePictureSelection)
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
         
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(196)
            make.width.equalTo(151)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        
        self.profileImageView = imageView
    }
}
