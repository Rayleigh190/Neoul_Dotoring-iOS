//
//  MentoringSetViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/01.
//

import UIKit

class MentoringMethodSetViewController: UIViewController {
    
    var mentoringSetView: MentoringMethodSetView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        mentoringSetView.inputTextField.delegate = self
        setNavigationItems()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func loadView() {
        super.loadView()
        
        mentoringSetView = MentoringMethodSetView(frame: self.view.frame)

        self.view = mentoringSetView
    }
    
    private func setNavigationItems() {
        navigationItem.title = "멘토링 방식 설정"
        navigationController?.navigationBar.topItem?.backButtonTitle = "마이페이지"
        navigationController?.navigationBar.tintColor = .label
        
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
    
}
