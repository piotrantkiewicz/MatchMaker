import UIKit
import PhoneNumberKit
import SnapKit
import DesignSystem


enum OTPStrings: String {
    case title = "Enter the 6 digit code."
    case subtitle = "Enter the 6 digit code sent to your device to verify your account."
    case continueButton = "Continue"
    case codeLabel = "Didn’t get a code? "
    case resendLabel = "Resend"
}


public class OTPViewController: UIViewController {
    
    private weak var stackView: UIStackView!
    private weak var continueBtn: UIButton!
    
    private var textFields: [UITextField] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureKeyboard()
        setupHideKeyboardGesture()
        
        textFields.first?.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

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
    
    private func setupHideKeyboardGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension OTPViewController {
    private func setupUI() {
        view.backgroundColor = .white
        setupStackView()
        setupTitle()
        setupSubtitle()
        setupTextFields()
        setupContinueButton()
        setupResendLabel()
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
        label.text = OTPStrings.title.rawValue
        label.font = .title
        label.numberOfLines = 0
        
        stackView.addArrangedSubview(label)
    }
    
    private func setupSubtitle() {
        let label = UILabel()
        label.textColor = UIColor(resource: .subtitleText)
        label.text = OTPStrings.subtitle.rawValue
        label.font = .subtitle
        label.numberOfLines = 0
        
        stackView.addArrangedSubview(label)
    }
    
    private func setupTextFields() {
        var fields = [UITextField]()
        
        let fieldsStackView = UIStackView()
        fieldsStackView.axis = .horizontal
        fieldsStackView.distribution = .equalSpacing
        fieldsStackView.alignment = .center
        
        for index in 0...5 {
            let background = UIView()
            
            background.layer.cornerRadius = 13.52
            background.layer.masksToBounds = true
            
            let textField = UITextField()
            textField.textAlignment = .center
            textField.textColor = .white
            textField.font = .otp
            textField.keyboardType = .numberPad
            textField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
            textField.tag = 100 + index
            
            background.addSubview(textField)
            
            background.snp.makeConstraints { make in
                make.height.equalTo(48)
                make.width.equalTo(48)
            }
            
            textField.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            fieldsStackView.addArrangedSubview(background)
            fields.append(textField)
        }
        
        stackView.addArrangedSubview(fieldsStackView)
        
        fieldsStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        view.layoutIfNeeded()
        
        for field in fields {
            field.superview?.applyGradient(
                colours: [UIColor(resource: .otpTextFieldGradientStart), UIColor(resource: .otpTextFieldGradientEnd)],
                startPoint: CGPoint(x: -0.15, y: 1.15),
                endPoint: CGPoint(x: 1, y: 0)
            )
        }
        
        textFields = fields
    }
    
    @objc func didChangeText(textField: UITextField) {
        textField.superview?.layer.sublayers?.first?.removeFromSuperlayer()
        textField.superview?.applyGradient(
            colours: [UIColor(resource: .accent), UIColor(resource: .backgroundPink)],
            startPoint: CGPoint(x: -0.15, y: 1.15),
            endPoint: CGPoint(x: 1, y: 0)
        )
        
        let index = textField.tag - 100
        
        let nextIndex = index + 1
        
        guard nextIndex < textFields.count else {
            continueBtn.alpha = 1.0
            return
        }
        
        textFields[nextIndex].becomeFirstResponder()
        
    }
    
    private func setupContinueButton() {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .button
        button.setTitle(OTPStrings.continueButton.rawValue, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        
        view.addSubview(button)

        button.snp.makeConstraints { make in
            make.height.equalTo(58)
            make.width.equalTo(306)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-48)
        }

        view.layoutIfNeeded()
        button.applyGradient(colours: [UIColor(resource: .accent), UIColor(resource: .backgroundPink)])

        self.continueBtn = button
    }
    
    private func setupResendLabel() {
        let label = UILabel()
        let string = NSMutableAttributedString()
        let codeLabel = NSAttributedString(string: OTPStrings.codeLabel.rawValue, attributes: [
            .font: UIFont.codeLabel,
            .foregroundColor: UIColor(resource: .subtitleText)
        ])
        string.append(codeLabel)
        let resendLabel = NSAttributedString(string: OTPStrings.resendLabel.rawValue, attributes: [
            .font: UIFont.resendLabel,
            .foregroundColor: UIColor(resource: .accent)
        ])
        string.append(resendLabel)
        
        label.attributedText = string
        
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(continueBtn.snp.bottom).offset(25)
        }
    }
}





