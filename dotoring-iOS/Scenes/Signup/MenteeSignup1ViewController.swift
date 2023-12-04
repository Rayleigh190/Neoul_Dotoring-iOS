//
//  MenteeSignup1ViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/26.
//

import UIKit

class MenteeSignup1ViewController: UIViewController {
    
    // 뷰 전체 높이 길이
    let screenHeight = UIScreen.main.bounds.size.height
    
    private lazy var stepBar: SignupStepBar = {
        let bar = SignupStepBar(stepCount: 6, currentStep: 1, style: .mentee)
        
        return bar
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 24)
        let text = "Q. 멘티님은 어떤 분인가요?"
        label.text = text
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.BaseNavy!, range: (text as NSString).range(of: "멘티"))
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var content1Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "A. 저는"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var content2Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "에 다니는"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var content3Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "학년"
        
        return label
    }()
    
    private lazy var content4Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "학생입니다."
        
        return label
    }()
    
    private lazy var content5Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "저는"
        
        return label
    }()
    
    private lazy var content6Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "의 멘토를 만나길 희망합니다."
        
        return label
    }()
    
    private lazy var schoolTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.textAlignment = .center
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let centeredPlaceholder = NSAttributedString(string: "학교", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        lineTextField.textField.attributedPlaceholder = centeredPlaceholder
        lineTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return lineTextField
    }()
    
    private lazy var gradeTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.textAlignment = .center
        lineTextField.textField.keyboardType = .numberPad
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let centeredPlaceholder = NSAttributedString(string: "학년", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        lineTextField.textField.attributedPlaceholder = centeredPlaceholder
        
        return lineTextField
    }()
    
    private lazy var departmentTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.textAlignment = .center
        lineTextField.isUserInteractionEnabled = false

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let centeredPlaceholder = NSAttributedString(string: "학과", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        lineTextField.textField.attributedPlaceholder = centeredPlaceholder
        
        return lineTextField
    }()
    
    private lazy var departmentTextFieldButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectTextFieldTapped), for: .touchUpInside)
               
        return button
    }()
    
    private lazy var fieldTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.textAlignment = .center
        lineTextField.isUserInteractionEnabled = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let centeredPlaceholder = NSAttributedString(string: "멘토링 분야", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        lineTextField.textField.attributedPlaceholder = centeredPlaceholder
        
        return lineTextField
    }()
    
    private lazy var fieldTextFieldButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectTextFieldTapped), for: .touchUpInside)
               
        return button
    }()
    
    private lazy var nextButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("다음", for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        self.hideKeyboardWhenTappedAround()
        setupSubViews()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(true)
    }
    
    @objc func nextButtonTapped(sender: UIButton!) {
        let vc = Signup2ViewController()
        navigationController?.pushViewController(vc, animated: false)
    }

}

private extension MenteeSignup1ViewController {
    
    func setupUI() {
        self.navigationController?.navigationBar.tintColor = .BaseGray700
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let titleLabel = UILabel()
        titleLabel.text = "멘티로 회원가입"
        titleLabel.textColor = UIColor.label // 전체 글씨 색상
        titleLabel.font = .nanumSquare(style: .NanumSquareOTFR, size: 15)
        titleLabel.sizeToFit()

        let mentorRange = (titleLabel.text! as NSString).range(of: "멘티")
        let attributedString = NSMutableAttributedString(string: titleLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.BaseNavy!, range: mentorRange)

        titleLabel.attributedText = attributedString

        self.navigationItem.titleView = titleLabel
    
    }
    
    func setupSubViews() {
        
        [stepBar, titleLabel, nextButton, departmentTextFieldButton, fieldTextFieldButton].forEach {view.addSubview($0)}
        
        [content1Label, content2Label, content3Label, content4Label, content5Label, content6Label].forEach {view.addSubview($0)}
        
        [schoolTextField, gradeTextField, departmentTextField, fieldTextField].forEach {view.addSubview($0)}
        
        stepBar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(17)
            if screenHeight <= 568 {
                $0.top.equalToSuperview().inset(70)
            } else {
                $0.top.equalToSuperview().offset(147).priority(.low)
                $0.top.greaterThanOrEqualToSuperview().inset(30).priority(.required)
            }
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(stepBar.snp.leading)
            $0.top.equalTo(stepBar.snp.bottom).offset(25)
        }
        
        content1Label.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(65)
        }
        
        schoolTextField.snp.makeConstraints {
            $0.centerY.equalTo(content1Label)
            $0.leading.equalTo(content1Label.snp.trailing).offset(17)
            $0.width.greaterThanOrEqualTo(80)
        }
        
        content2Label.snp.makeConstraints {
            $0.centerY.equalTo(schoolTextField)
            $0.leading.equalTo(schoolTextField.snp.trailing).offset(17)
            $0.trailing.equalToSuperview().inset(58).priority(.high)
            $0.trailing.greaterThanOrEqualToSuperview().inset(16).priority(.high)
        }
        
        gradeTextField.snp.makeConstraints {
            $0.centerX.equalTo(schoolTextField)
            $0.top.equalTo(schoolTextField.snp.bottom).offset(20)
            $0.leading.equalTo(schoolTextField.snp.leading)
        }
        
        content3Label.snp.makeConstraints {
            $0.centerY.equalTo(gradeTextField)
            $0.width.equalTo(91)
            $0.trailing.greaterThanOrEqualToSuperview().inset(41)
        }
        
        departmentTextField.snp.makeConstraints {
            $0.centerX.equalTo(gradeTextField)
            $0.top.equalTo(gradeTextField.snp.bottom).offset(20)
            $0.leading.equalTo(gradeTextField.snp.leading)
        }
        
        content4Label.snp.makeConstraints {
            $0.centerY.equalTo(departmentTextField)
            $0.leading.equalTo(content3Label.snp.leading)
        }
        
        content5Label.snp.makeConstraints {
            $0.leading.equalTo(content1Label.snp.leading).offset(25)
            $0.top.equalTo(departmentTextField.snp.bottom).offset(26)
        }
        
        fieldTextField.snp.makeConstraints {
            $0.centerX.equalTo(departmentTextField)
            $0.top.equalTo(departmentTextField.snp.bottom).offset(15)
            $0.leading.equalTo(departmentTextField.snp.leading)
        }
        
        content6Label.snp.makeConstraints {
            $0.trailing.equalTo(content4Label.snp.trailing)
            $0.top.equalTo(fieldTextField.snp.bottom).offset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(content6Label.snp.bottom).offset(55)
            $0.height.equalTo(48)
            $0.bottom.lessThanOrEqualToSuperview().inset(20).priority(.required)
        }
        
        departmentTextFieldButton.snp.makeConstraints {
            $0.width.height.equalTo(departmentTextField)
            $0.centerX.centerY.equalTo(departmentTextField)
        }
        
        fieldTextFieldButton.snp.makeConstraints {
            $0.width.height.equalTo(fieldTextField)
            $0.centerX.centerY.equalTo(fieldTextField)
        }
        
    }
}

extension MenteeSignup1ViewController: SelectViewControllerDelegate {
    
    @objc private func selectTextFieldTapped(sender: UIButton) {
        let vc = SelectViewController()
        if sender == fieldTextFieldButton {
            vc.selectViewControllerDelegate = self
            vc.titleText = "멘토링 분야 선택"
            vc.style = .mentee
        } else if sender == departmentTextFieldButton {
            vc.selectViewControllerDelegate = self
            vc.titleText = "학과 선택"
            vc.style = .mentee
        } else {
            vc.selectViewControllerDelegate = self
            vc.titleText = "필터"
        }
        vc.sender = sender
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 30
            sheet.prefersGrabberVisible = true
       }
       present(vc, animated: true)
    }
    
    // 직무선택, 학과선택 뷰컨트롤러 화면이 사라질 때 선택한 데이터를 받음
    func didSelectViewControllerDismiss(elements: [String], selectedElements: [Int], sender: UIButton) {
        // 선택한 데이터가 0개 이상일 때만 데이터 저장 및 뷰 수정
        if selectedElements.count > 0 {
            // 이 뷰컨트롤러에 데이터 저장하는 코드 추가해야 됨
            var selectedElementString: String = ""
            for selectedElement in selectedElements {
                print(elements[selectedElement])
                selectedElementString += (elements[selectedElement]+", ")
            }
            selectedElementString = String(selectedElementString.dropLast(2))
            
            if sender == fieldTextFieldButton {
                fieldTextField.textField.text = selectedElementString
            } else {
                departmentTextField.textField.text = selectedElementString
            }
            
        }
        
    }
    
}

