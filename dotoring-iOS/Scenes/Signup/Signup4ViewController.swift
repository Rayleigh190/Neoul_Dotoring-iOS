//
//  MentoSignup4ViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/23.
//

import UIKit

class Signup4ViewController: UIViewController, KeyboardEvent {
    // Signup Data
    var school: String = ""
    var grade: Int = 0
    var fields: [String] = []
    var majors: [String] = []
    var certificationsFileURL: URL?
    var nickname: String = ""
    var isDoc = false
    
    // 키보드 이벤트를 받을 때 움직일 뷰를 정해줍니다.
    var transformView: UIView { return self.view }
    var signup4View: Signup4View!
    
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
        signup4View.tag1TextField.textField.delegate = self
        self.hideKeyboardWhenTappedAround()
        setAddTarget()
        setupNavigationBar()
        
        // KeyboardEvent의 setupKeyboardEvent
        setupKeyboardEvent()
    }
    
    override func loadView() {
        super.loadView()
        
        signup4View = Signup4View(frame: self.view.frame)
        
        signup4View.nextButtonActionHandler = { [weak self] in
            self?.nextButtonTapped()
        }
        
        self.view = signup4View
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.setAnimationsEnabled(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(false)
    }

    // KeyboardEvent에서 사용된 addObserver는 자동으로 제거가 안되므로 여기선 제거해 줍시다.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // KeyboardEvent의 removeKeyboardObserver
        removeKeyboardObserver()
    }
    
    func nextButtonTapped() {
        let vc = Signup5ViewController()
        vc.school = school
        vc.grade = grade
        vc.fields = fields
        vc.majors = majors
        vc.certificationsFileURL = certificationsFileURL
        vc.nickname = nickname
        vc.introduction = "안녕하세요 전남대학교 4학년 최우진입니다."
        vc.isDoc = isDoc
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.tintColor = .BaseGray700
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.backgroundColor = .white
        
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

extension Signup4ViewController {
    func setAddTarget() {
        signup4View.tag1TextField.button.addTarget(self, action: #selector(removeTag), for: .touchUpInside)
    }
    
    @objc func removeTag(sender: UIButton) {
        signup4View.tagStackView.arrangedSubviews.forEach {

            if $0 != sender.superview?.superview {
                return
            }
            
            // 첫 번째 태그는 글씨만 지웁니다.
            if signup4View.tagStackView.arrangedSubviews.count == 1 {
                let tag = signup4View.tagStackView.arrangedSubviews[0] as! TagTextField
                tag.textField.text = ""
            }
            
            // 첫 번째 태그가 아니면 stackView에서 TagTextField를 지웁니다.
            if signup4View.tagStackView.arrangedSubviews.count != 1{
                signup4View.tagStackView.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
        }
    }
}

extension Signup4ViewController: UITextFieldDelegate {
    
    func addTagTextField() {
        // text.count가 0인 태그 필드가 있으면 return
        signup4View.tagStackView.arrangedSubviews.forEach {
            let tag = $0 as! TagTextField
            if tag.textField.text?.count == 0 {
                return
            }
        }
        
        let tag = TagTextField()
        tag.textField.delegate = self
        tag.button.addTarget(self, action: #selector(removeTag), for: .touchUpInside)

        signup4View.tagStackView.addArrangedSubview(tag)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.count == 0 {
            textField.text = "#"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // text.count가 0인 필드가 없으면 새로운 필드 만들고 포커싱 옮기기
        for view in signup4View.tagStackView.arrangedSubviews {
            let tag = view as! TagTextField
            let lastTag = signup4View.tagStackView.arrangedSubviews.last as! TagTextField
            
            if tag.textField.text?.count == 0 {
                tag.textField.becomeFirstResponder()
                return true
            }
            
            // 마지막 태그에서 리턴 눌렀을 경우 키보드 내리기
            if textField == lastTag.textField {
                textField.resignFirstResponder()
            }
        }
        
        // 태그가 3개 미만이면 태그 추가
        if signup4View.tagStackView.arrangedSubviews.count < 3 {
            addTagTextField()
            let newTag = signup4View.tagStackView.arrangedSubviews.last as! TagTextField
            newTag.textField.becomeFirstResponder()
        }
        
        return true
    }
    
    // textField 글자수 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inputString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textField.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)

        let characterCount = newString.count
        
        guard characterCount <= 7 else {
            print(characterCount)
            self.view.makeToast("6자 이하까지 작성 가능합니다.", duration: 1, position: .top)
            return false
        }

        return true
    }
}
