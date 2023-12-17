//
//  MentoSignup4ViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/23.
//

import UIKit

class Signup4ViewController: UIViewController {

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
//        signup4View.introductionInputTextField.delegate = self
        signup4View.tag1TextField.textField.delegate = self
//        signup4View.tag2TextField.textField.delegate = self
//        signup4View.tag3TextField.textField.delegate = self
        self.hideKeyboardWhenTappedAround()
        setAddTarget()
        setupNavigationBar()
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
    
    func nextButtonTapped() {
        let vc = Signup5ViewController()
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
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("끝남")
        
        if textField.text?.count ?? 0 == 0 {
            print("입력된 값 없음")
            return
        }
        
        if signup4View.tagStackView.arrangedSubviews.count > 2 {
            return
        }
        
        let tag = TagTextField()
        tag.textField.delegate = self
        tag.snp.makeConstraints{$0.height.equalTo(40)}
        tag.button.addTarget(self, action: #selector(removeTag), for: .touchUpInside)
        signup4View.tagStackView.addArrangedSubview(tag)
        
//        if textField == signup4View.tag1TextField.textField {
////            signup4View.tag2TextField.isHidden = false
////            signup4View.tag1TextField.button.isHidden = false
//            let tag = TagTextField()
//            tag.textField.delegate = self
//            tag.snp.makeConstraints{$0.height.equalTo(40)}
//            signup4View.tagStackView.addArrangedSubview(tag)
//        } else if textField == signup4View.tagStackView.arrangedSubviews[1] {
////            signup4View.tag3TextField.isHidden = false
////            signup4View.tag2TextField.button.isHidden = false
//            signup4View.tagStackView.addArrangedSubview(TagTextField())
//        } else {
////            signup4View.tag3TextField.button.isHidden = false
//        }
    }
}

extension Signup4ViewController: UITextViewDelegate {
    
    // MARK: textview 높이 자동조절
    func textViewDidChange(_ textView: UITextView) {
        
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    // textView 포커싱 됐을 때 placeholder text 지우기
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "멘토 분야에 대해 소개해 주세요" {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // textView 포커싱 끝났을 때 빈칸이면 placeholder text 채우기
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "멘토 분야에 대해 소개해 주세요"
            textView.textColor = .lightGray
        }
    }
    
    // textView 글자수 제한
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)

        let characterCount = newString.count
        guard characterCount <= 80 else { return false }
        signup4View.updateCountLabel(characterCount: characterCount)

        return true
    }
}
