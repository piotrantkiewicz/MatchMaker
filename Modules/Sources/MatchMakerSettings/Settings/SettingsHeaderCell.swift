import UIKit
import DesignSystem
import SDWebImage
import SnapKit

class SettingsHeaderCell: UITableViewCell {
    
    private var containerView: UIView!
    private var stackView: UIStackView!
    private var profileImageView: UIImageView!
    private var nameLbl: UILabel!
    private var locationLbl: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func configure(with viewModel: SettingsViewModel.Header) {
        if let url = viewModel.imageUrl {
            profileImageView.sd_setImage(with: url)
        }
        nameLbl.text = viewModel.name
        locationLbl.text = viewModel.location
    }
    
    private func commonInit() {
        selectionStyle = .none
        
        setupUI()
    }
}

extension SettingsHeaderCell {
    
    private func setupUI() {
        setupImageView()
        setupLabels()
    }
    
    private func setupImageView() {
        profileImageView = UIImageView()
        profileImageView.layer.cornerRadius = 15
        profileImageView.layer.masksToBounds = true
        profileImageView.image = UIImage(resource: .profilePicturePlaceholder)
        profileImageView.contentMode = .scaleAspectFill
        contentView.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(74)
            make.left.equalToSuperview().offset(32)
            make.top.equalToSuperview().offset(14)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setupLabels() {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 1
        
        contentView.addSubview(labelsStackView)
        
        labelsStackView.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(24)
            make.right.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview().offset(-24)
        }
        
        let nameLbl = setupNameLbl()
        labelsStackView.addArrangedSubview(nameLbl)
        self.nameLbl = nameLbl
        
        let locationLbl = setupLocationLbl()
        labelsStackView.addArrangedSubview(locationLbl)
        self.locationLbl = locationLbl
    }
    
    private func setupNameLbl() -> UILabel {
        let nameLbl = UILabel()
        nameLbl.font = .title2
        nameLbl.textColor = .black
        return nameLbl
    }
    
    private func setupLocationLbl() -> UILabel {
        let locationLbl = UILabel()
        locationLbl.font = .subtitle2
        locationLbl.textColor = .subtitleGray
        return locationLbl
    }
}
