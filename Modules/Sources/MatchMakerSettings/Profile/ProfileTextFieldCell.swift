import UIKit
import SnapKit

class ProfileTextFieldCell: UITableViewCell {
    
    struct Model {
        let icon: UIImage
        let placeholderText: String
        let text: String?
        let isValid: Bool
    }
    
    weak var textField: UITextField!
    private weak var iconImageView: UIImageView!
    private weak var checkMarkImageView: UIImageView!
    private weak var containerView: UIView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func configure(with model: Model) {
        textField.placeholder = model.placeholderText
        textField.text = model.text
        iconImageView.image = model.icon
        configureCheckMark(for: model)
    }
    
    private func configureCheckMark(for model: Model) {
        checkMarkImageView.image = checkMarkImage(for: model)
        
        if  model.isValid  {
            setConfigureCheckMarkShadowEnabled()
        } else {
            checkMarkImageView.layer.shadowOpacity = 0
        }
    }
    
    private func setConfigureCheckMarkShadowEnabled() {
        checkMarkImageView.layer.shadowColor = UIColor.pinkShadow.withAlphaComponent(0.65).cgColor
        checkMarkImageView.layer.shadowOpacity = 1
        checkMarkImageView.layer.shadowOffset = CGSize(width: 0, height: 10)
        checkMarkImageView.layer.shadowRadius = 35
    }
    
    private func checkMarkImage(for model: Model) -> UIImage {
        model.isValid ? UIImage(resource: .checkMarkSelected) : UIImage(resource: .checkMark)
    }
    
    private func commonInit() {
        setupUI()
    }
}

extension ProfileTextFieldCell {
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        layer.masksToBounds = false
        clipsToBounds = false
        contentView.layer.masksToBounds = false
        contentView.clipsToBounds = false
        
        setupContainer()
        setupIcon()
        setupTextField()
        setupCheckMark()
    }
    
    private func setupContainer() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 15
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.grayShadow.withAlphaComponent(0.2).cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 75
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(61)
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-35)
            make.bottom.equalToSuperview()
        }
        
        self.containerView = containerView
    }
    
    private func setupIcon() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        containerView.addSubview(imageView)
         
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
            make.left.equalToSuperview().offset(15)
        }
        
        iconImageView = imageView
    }
    
    private func setupTextField() {
        let textField = UITextField()
        textField.font = .textField2
        textField.textColor = .black
        
        containerView.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(13)
            make.centerY.equalToSuperview()
        }
        
        self.textField = textField
    }
    
    private func setupCheckMark() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        containerView.addSubview(imageView)
         
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(23)
            make.left.equalTo(textField.snp.right).offset(18)
            make.right.equalToSuperview().offset(-19)
        }
        
        self.checkMarkImageView = imageView
    }
}
