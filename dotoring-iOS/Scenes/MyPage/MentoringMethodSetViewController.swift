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
            textView.textColor = .BaseGray900
            textView.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 17)
        }
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
