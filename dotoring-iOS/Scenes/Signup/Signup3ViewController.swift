//
//  MentoSignup3ViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/22.
//

import UIKit

class Signup3ViewController: UIViewController {
    // Signup Data
    var school: String = ""
    var grade: Int = 0
    var fields: [String] = []
    var majors: [String] = []
    var certificationsFileURL: URL?
    //
    var isNicknameValid = false
    var inputNickname: String = ""
    
    var signup3View: Signup3View!
    
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
        setupNavigationBar()
        setAddTarget()
        signup3View.nickNameTextField.textField.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        
        signup3View = Signup3View(frame: self.view.frame)
        
        signup3View.nextButtonActionHandler = { [weak self] in
            self?.nextButtonTapped()
        }
        
        self.view = signup3View
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.setAnimationsEnabled(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(false)
    }
    
    func nextButtonTapped() {
        if isNicknameValid == false {
            Alert.showAlert(title: "안내", message: "닉네임 중복 확인을 해주세요.")
            return
        }
        let vc = Signup4ViewController()
        vc.school = school
        vc.grade = grade
        vc.fields = fields
        vc.majors = majors
        vc.certificationsFileURL = certificationsFileURL
        vc.nickname = inputNickname
        navigationController?.pushViewController(vc, animated: false)
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

}

extension Signup3ViewController {
    
    func containsNumber(in text: String) -> Bool {
        let numberCharacterSet = CharacterSet(charactersIn: "0123456789")
        return text.rangeOfCharacter(from: numberCharacterSet) != nil
    }
    
    @objc func validNickname() {
        if inputNickname.count < 3
            || inputNickname.count > 8 {
            Alert.showAlert(title: "안내", message: "3자 이상, 8자 이하로 입력하세요.")
            return
        }
        
        if !containsNumber(in: inputNickname) {
            Alert.showAlert(title: "안내", message: "숫자를 1개 이상 입력하세요.")
            return
        }
        self.view.makeToastActivity(.center)
        SignupNetworkService.validNickname(uiStyle: uiStyle, nickname: inputNickname) { response, error in
            self.signup3View.nickNameWarningLabel.isHidden = true
            if response?.success == false {
                // 닉네임 중복 발생
                if response?.error?.code == "4009" {
                    self.signup3View.nickNameWarningLabel.isHidden = false
                    return
                }
            } else if response?.success == true {
                debugPrint(response!)
                Alert.showAlert(title: "안내", message: "사용 가능한 닉네임입니다.")
                self.isNicknameValid = true
                
            } else {
                Alert.showAlert(title: "오류", message: "알 수 없는 오류입니다. 다시 시도해 주세요. code : \(response?.error?.code ?? "0")")
            }
            
        }
        self.view.hideToastActivity()
    }
    
    func setAddTarget() {
        signup3View.nickNameTextField.button.addTarget(self, action: #selector(validNickname), for: .touchUpInside)
        
        signup3View.nickNameTextField.textField.addTarget(self, action: #selector(textFieldDidChanacge), for: .editingChanged)
    }
    
}

extension Signup3ViewController: UITextFieldDelegate {
    
    // 닉네임 수정 했을때 isNicknameValid = false 하기
    @objc func textFieldDidChanacge(_ sender: Any?) {
        isNicknameValid = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let inputNickname = signup3View.nickNameTextField.textField.text {
            self.inputNickname = inputNickname
        }
    }
}
