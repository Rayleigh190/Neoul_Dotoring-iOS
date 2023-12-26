//
//  MentoSignup6ViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/24.
//

import UIKit

class Signup6ViewController: UIViewController {
    // Signup Data
    var school: String = ""
    var grade: Int = 0
    var fields: [String] = []
    var majors: [String] = []
    var certificationsFileURL: URL?
    var nickname: String = ""
    var introduction: String = ""
    
    var isIdValid = false
    var isRePwValid = false

    var signup6View: Signup6View!
    var fCurTextfieldBottom: CGFloat = 0.0
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.hideKeyboardWhenTappedAround()
        navigationController?.navigationBar.topItem?.title = ""
        setDelegate()
        registerForKeyboardNotifications()
        setupNavigationBar()
        setAddTarget()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    override func loadView() {
        super.loadView()
        
        signup6View = Signup6View(frame: self.view.frame)
        
        signup6View.loginButtonActionHandler = { [weak self] in
            self?.loginButtonTapped()
        }
        
        self.view = signup6View
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.setAnimationsEnabled(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(false)
    }
    
    func setDelegate() {
        signup6View.idTextField.textField.delegate = self
        signup6View.pwTextField.textField.delegate = self
        signup6View.rePwTextField.textField.delegate = self
        signup6View.emailTextField.textField.delegate = self
        signup6View.authCodeTextField.textField.delegate = self
    }
    
    func loginButtonTapped() {
        if let viewControllers = self.navigationController?.viewControllers, viewControllers.count >= 8 {
            let destinationVC = viewControllers[viewControllers.count - 8]
            self.navigationController?.popToViewController(destinationVC, animated: true)
        }
    }
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.tintColor = .BaseGray700
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let titleLabel = UILabel()
        var attrRangeText = ""
        var attrStrColor = UIColor.label

        titleLabel.textColor = UIColor.label // 전체 글씨 색상
        titleLabel.font = .nanumSquare(style: .NanumSquareOTFR, size: 15)
        titleLabel.sizeToFit()

        if uiStyle == .mentee {
            titleLabel.text = "멘티로 회원가입"
            attrRangeText = "멘티"
            attrStrColor = .BaseNavy!
        } else {
            titleLabel.text = "멘토로 회원가입"
            attrRangeText = "멘토"
            attrStrColor = .BaseGreen!
        }
        
        let attributedString = NSMutableAttributedString(string: titleLabel.text!)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: attrStrColor, range: (titleLabel.text! as NSString).range(of: attrRangeText))

        titleLabel.attributedText = attributedString

        self.navigationItem.titleView = titleLabel
    }
    
    func setAddTarget() {
        signup6View.idTextField.button.addTarget(self, action: #selector(validId), for: .touchUpInside)
        signup6View.idTextField.textField.addTarget(self, action: #selector(textFieldDidChanacge), for: .editingChanged)
        signup6View.pwTextField.textField.addTarget(self, action: #selector(textFieldDidChanacge), for: .editingChanged)
    }
}

extension Signup6ViewController: UITextFieldDelegate {
    
    // 텍스트필드에서 리턴키 눌르면 다음 텍스트필드로 포커싱 맞춰짐
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == signup6View.idTextField.textField {
            signup6View.pwTextField.textField.becomeFirstResponder()
        } else if textField == signup6View.pwTextField.textField {
            signup6View.rePwTextField.textField.becomeFirstResponder()
        } else if textField == signup6View.rePwTextField.textField {
            signup6View.emailTextField.textField.becomeFirstResponder()
        } else if textField == signup6View.emailTextField.textField{
            signup6View.authCodeTextField.textField.becomeFirstResponder()
        } else {
            signup6View.authCodeTextField.textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let textFieldFrame = textField.convert(textField.bounds, to: self.view)
        fCurTextfieldBottom = textFieldFrame.origin.y + textFieldFrame.size.height
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if fCurTextfieldBottom <= self.view.frame.height - keyboardSize.height {
                return
            }
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // 입력값 수정 했을때 is..Valid = false 하기
    @objc func textFieldDidChanacge(_ sender: UITextField?) {
        if sender == signup6View.idTextField.textField {
            isIdValid = false
        }
        
        if sender == signup6View.pwTextField.textField {
            signup6View.rePwTextField.textField.text = ""
            signup6View.pwChekButton.tintColor = .BaseGray400
            isRePwValid = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == signup6View.pwTextField.textField {
            guard let pwCount = textField.text?.count else {return}
            if pwCount > 0 {
                signup6View.rePwTextField.textField.isEnabled = true
            } else {
                signup6View.rePwTextField.textField.isEnabled = false
            }
        }
        
        if textField == signup6View.rePwTextField.textField {
            signup6View.pwWarningLabel.isHidden = true
            guard let inputPw = signup6View.pwTextField.textField.text else {return}
            if textField.text == inputPw {
                isRePwValid = true
                if uiStyle == .mento {
                    signup6View.pwChekButton.tintColor = .BaseGreen
                } else {
                    signup6View.pwChekButton.tintColor = .BaseNavy
                }
            } else {
                isRePwValid = false
                signup6View.pwChekButton.tintColor = .BaseGray400
                signup6View.pwWarningLabel.isHidden = false
            }
        }
    }
    
}

extension Signup6ViewController {
    
    func isPwValid(pw: String) -> Bool {
        // 정규표현식 패턴
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\",./<>?])([A-Za-z\\d!@#$%^&*()_+\\-=\\[\\]{};':\",./<>?]){7,12}$"
        
        // NSPredicate를 사용하여 패턴 검증
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: pw)
    }
    
    
    // Network
    
    @objc func validId() {
        
        self.signup6View.idWarningLabel.isHidden = true
        
        guard let inputId = signup6View.idTextField.textField.text else {return}
        
        self.view.makeToastActivity(.center)
        SignupNetworkService
            .validId(loginId: inputId) { response, error in
                if response?.success == false {
                    if response?.error?.code == "4010" {
                        // 아이디 중복발생
                        self.signup6View.idWarningLabel.isHidden = false
                        return
                    } else {
                        Alert.showAlert(title: "안내", message: response?.error?.code ?? "알 수 없는 오류")
                        return
                    }
                } else if response?.success == true {
                    debugPrint(response!)
                    Alert.showAlert(title: "안내", message: "사용 가능한 아이디입니다.")
                    self.isIdValid = true
                } else {
                    Alert.showAlert(title: "오류", message: "알 수 없는 오류입니다. 다시 시도해 주세요. code : \(response?.error?.code ?? "0")")
                }
            }
        self.view.hideToastActivity()
    }
    
}
