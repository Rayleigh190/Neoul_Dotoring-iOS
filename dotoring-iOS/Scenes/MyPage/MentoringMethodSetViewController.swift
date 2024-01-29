//
//  MentoringSetViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/01.
//

import UIKit

class MentoringMethodSetViewController: UIViewController {
    var isChanged = false
    var mentoringSetView: MentoringMethodSetView!
    var previousMentoringMethod = ""
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
        mentoringSetView.inputTextField.delegate = self
        mentoringSetView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        setupNavigationController()
        updateUI()
        setAddTarget()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func loadView() {
        super.loadView()
        
        mentoringSetView = MentoringMethodSetView(frame: self.view.frame)

        self.view = mentoringSetView
    }
    
    private func setupNavigationController() {
        navigationItem.title = "멘토링 방식 설정"
        navigationController?.navigationBar.tintColor = .label
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
    @objc func cancelButtonTapped(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func updateUI() {
        if previousMentoringMethod.count > 0 {
            mentoringSetView.inputTextField.text = previousMentoringMethod
            textViewDidChange(mentoringSetView.inputTextField)
        }
    }
    
    func setAddTarget() {
        mentoringSetView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

}

extension MentoringMethodSetViewController {
    @objc func saveButtonTapped() {
        if mentoringSetView.inputTextField.text.count < 10 {
            Alert.showAlert(title: "알림", message: "최소 10자 이상 작성해야 합니다.")
            return
        }
        
        MyPageNetworkService.patchMentoringMethod(uiStyle: uiStyle, text: mentoringSetView.inputTextField.text) { response, error in
            if error != nil {
                print("멘토링 방식 수정 요청 오류 발생: \(error?.asAFError?.responseCode ?? 0)")
                if let statusCode = error?.asAFError?.responseCode {
                    Alert.showAlert(title: "멘토링 방식 수정 요청 오류 발생", message: "\(statusCode)")
                } else {
                    Alert.showAlert(title: "멘토링 방식 수정 요청 오류 발생", message: "네트워크 연결을 확인하세요.")
                }
            } else{
                if response?.success == true {
                    print(response!)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    Alert.showAlert(title: "오류", message: "알 수 없는 오류입니다. 다시 시도해 주세요. code : \(response?.error?.code ?? "0")")
                }
            }
            
        }
    }
}

extension MentoringMethodSetViewController: UITextViewDelegate {
    
    // textView 글자수 제한
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)

        let characterCount = newString.count
        guard characterCount <= 250 else { return false }
        mentoringSetView.updateCountLabel(characterCount: characterCount)

        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !isChanged {
            textView.text = ""
        }
        textView.textColor = .BaseGray900
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 17)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        isChanged = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if isChanged {
            if uiStyle == .mento {
                mentoringSetView.saveButton.setupButton(style: .green)
            } else {
                mentoringSetView.saveButton.setupButton(style: .navy)
            }
            mentoringSetView.saveButton.isEnabled = true
        }
    }
    
}
