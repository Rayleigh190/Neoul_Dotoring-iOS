//
//  MentoSignup4ViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/23.
//

import UIKit

class MentoSignup4ViewController: UIViewController {

    var signup4View: Signup4View!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        signup4View.introductionInputTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func loadView() {
        super.loadView()
        
        signup4View = Signup4View(frame: self.view.frame)
        
        signup4View.nextButtonActionHandler = { [weak self] in
            self?.nextButtonTapped()
        }
        
        self.view = signup4View
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.setAnimationsEnabled(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(false)
    }
    
    func nextButtonTapped() {
        let vc = MentoSignup5ViewController()
        navigationController?.pushViewController(vc, animated: false)
    }

}

extension MentoSignup4ViewController: UITextViewDelegate {
    
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
