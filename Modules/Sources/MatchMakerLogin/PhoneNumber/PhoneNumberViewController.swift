import UIKit
import PhoneNumberKit
import SnapKit
import DesignSystem
import MatchMakerAuth
import Swinject

enum PhoneNumberStrings: String {
    case title = "Can I get those digits?"
    case subtitle = "Enter your phone number below to create your free account."
    case continueButton = "Continue"
}

public class PhoneNumberViewController: UIViewController {
    
    private weak var stackView: UIStackView!
    private weak var textField: PhoneNumberTextField!
    private weak var continueBtn: UIButton!
    
    public var viewModel: PhoneNumberViewModel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureKeyboard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension PhoneNumberViewController {
    private func configureKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        
        let animationCurveRawNumber = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNumber?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        let isKeyboardHidden = endFrame.origin.y >= UIScreen.main.bounds.size.height
        
        let topMargin = isKeyboardHidden ? -40 : -endFrame.height + view.safeAreaInsets.bottom - 16
        
        continueBtn.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(topMargin)
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: animationCurve) {
            self.view.layoutIfNeeded()
        }
    }
}

extension PhoneNumberViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        setupStackView()
        setupTitle()
        setupSubtitle()
        setupTextField()
        setupContinueButton()
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 32
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(48)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
        }
        
        self.stackView = stackView
    }
    
    private func setupTitle() {
        let label = UILabel()
        label.textColor = UIColor(resource: .accent)
        label.text = PhoneNumberStrings.title.rawValue
        label.font = .title
        label.numberOfLines = 0
        
        stackView.addArrangedSubview(label)
    }
    
    private func setupSubtitle() {
        let label = UILabel()
        label.textColor = UIColor(resource: .subtitleText)
        label.text = PhoneNumberStrings.subtitle.rawValue
        label.font = .subtitle
        label.numberOfLines = 0
        
        stackView.addArrangedSubview(label)
    }
    
    private func setupTextField() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 6
        backgroundView.layer.masksToBounds = false
        
        stackView.addArrangedSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalToSuperview()
        }
        
        view.layoutIfNeeded()
        
        backgroundView.layer.borderColor = UIColor(resource: .border).cgColor
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.shadowColor = UIColor.black.withAlphaComponent(0.07).cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 7)
        backgroundView.layer.shadowRadius = 64
        backgroundView.layer.shadowPath = UIBezierPath(roundedRect: backgroundView.bounds, cornerRadius: backgroundView.layer.cornerRadius).cgPath
        backgroundView.layer.shadowOpacity = 1
        
        let textField = PhoneNumberTextField(
            insets: UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8),
            clearButtonPadding: 0
        )
        
        textField.font = .textField
        textField.textColor = .black
        textField.withExamplePlaceholder = true
        textField.withFlag = true
        
        backgroundView.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        self.textField = textField
    }
    
    private func setupContinueButton() {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .button
        button.setTitle(PhoneNumberStrings.continueButton.rawValue, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        
        view.addSubview(button)

        button.snp.makeConstraints { make in
            make.height.equalTo(58)
            make.width.equalTo(306)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }

        view.layoutIfNeeded()
        button.applyGradient(colours: [UIColor(resource: .accent), UIColor(resource: .backgroundPink)])

        self.continueBtn = button
    }
}

extension PhoneNumberViewController {
    
    @objc func didTapContinue() {
        
        guard
            textField.isValidNumber,
            let phoneNumber = textField.text else { return }
        
        Task { [weak self] in
            do {
                try await self?.viewModel.requestOTP(with: phoneNumber)
            } catch {
                self?.showError(error.localizedDescription)
            }
        }
    }
}
