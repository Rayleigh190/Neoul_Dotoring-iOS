//
//  MenteeSignup1ViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/26.
//

import UIKit

class MenteeSignup1ViewController: UIViewController {
    
    private lazy var navTitleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 14)
        let text = "멘티로 회원가입"
        label.text = text
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.BaseNavy!, range: (text as NSString).range(of: "멘티"))
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var stepBar: SignupStepBar = {
        let bar = SignupStepBar(stepCount: 6, currentStep: 1, style: .mentee)
        
        return bar
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
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
        
        return label
    }()
    
    private lazy var content2Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "에 다니는"
        
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
        label.text = "을/를 희망합니다."
        
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
    
    private lazy var jobTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.textAlignment = .center
        lineTextField.isUserInteractionEnabled = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let centeredPlaceholder = NSAttributedString(string: "직무 분야", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        lineTextField.textField.attributedPlaceholder = centeredPlaceholder
        
        return lineTextField
    }()
    
    private lazy var jobTextFieldButton: UIButton = {
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
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        self.hideKeyboardWhenTappedAround()
        setupSubViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(true)
    }
    
    @objc func nextButtonTapped(sender: UIButton!) {
        let vc = MentoSignup2ViewController()
        navigationController?.pushViewController(vc, animated: false)
    }

}

private extension MenteeSignup1ViewController {
    
    func setupSubViews() {
        
        [navTitleLabel, stepBar, titleLabel, nextButton, departmentTextFieldButton, jobTextFieldButton].forEach {view.addSubview($0)}
        
        [content1Label, content2Label, content3Label, content4Label, content5Label, content6Label].forEach {view.addSubview($0)}
        
        [schoolTextField, gradeTextField, departmentTextField, jobTextField].forEach {view.addSubview($0)}
        
        navTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalToSuperview().offset(104)
        }
        
        stepBar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalTo(navTitleLabel.snp.bottom).offset(87)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalTo(stepBar.snp.bottom).offset(25)
        }
        
        content1Label.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(66)
        }
        
        schoolTextField.snp.makeConstraints {
            $0.centerY.equalTo(content1Label)
            $0.leading.equalTo(content1Label.snp.trailing).offset(17)
            $0.width.equalTo(100)
        }
        
        content2Label.snp.makeConstraints {
            $0.centerY.equalTo(schoolTextField)
            $0.leading.equalTo(schoolTextField.snp.trailing).offset(17)
        }
        
        gradeTextField.snp.makeConstraints {
            $0.centerX.equalTo(schoolTextField)
            $0.top.equalTo(schoolTextField.snp.bottom).offset(20)
            $0.width.equalTo(100)
        }
        
        content3Label.snp.makeConstraints {
            $0.centerY.equalTo(gradeTextField)
            $0.leading.equalTo(gradeTextField.snp.trailing).offset(17)
        }
        
        departmentTextField.snp.makeConstraints {
            $0.centerX.equalTo(gradeTextField)
            $0.top.equalTo(gradeTextField.snp.bottom).offset(20)
            $0.width.equalTo(100)
        }
        
        content4Label.snp.makeConstraints {
            $0.centerY.equalTo(departmentTextField)
            $0.leading.equalTo(departmentTextField.snp.trailing).offset(17)
        }
        
        content5Label.snp.makeConstraints {
            $0.leading.equalTo(content1Label.snp.leading).offset(25)
            $0.top.equalTo(departmentTextField.snp.bottom).offset(26)
        }
        
        jobTextField.snp.makeConstraints {
            $0.centerX.equalTo(departmentTextField)
            $0.top.equalTo(departmentTextField.snp.bottom).offset(20)
            $0.width.equalTo(100)
        }
        
        content6Label.snp.makeConstraints {
            $0.trailing.equalTo(content4Label.snp.trailing)
            $0.top.equalTo(jobTextField.snp.bottom).offset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalTo(content6Label.snp.bottom).offset(70)
            $0.height.equalTo(45)
        }
        
        departmentTextFieldButton.snp.makeConstraints {
            $0.width.height.equalTo(departmentTextField)
            $0.centerX.centerY.equalTo(departmentTextField)
        }
        
        jobTextFieldButton.snp.makeConstraints {
            $0.width.height.equalTo(jobTextField)
            $0.centerX.centerY.equalTo(jobTextField)
        }
        
    }
}

extension MenteeSignup1ViewController: JobSelectViewControllerDelegate, DepartmentSelectViewControllerDelegate {
    
    @objc private func selectTextFieldTapped(sender: UIButton) {
        var vc: UIViewController
        if sender == jobTextFieldButton {
            let jobSelectViewController = JobSelectViewController()
            jobSelectViewController.jobSelectViewControllerDelegate = self
            jobSelectViewController.titleText = "희망 직무 선택"
            jobSelectViewController.style = .mentee
            vc = jobSelectViewController
        } else if sender == departmentTextFieldButton {
            let departmentSelectViewController = DepartmentSelectViewController()
            departmentSelectViewController.departmentSelectViewControllerDelegate = self
            departmentSelectViewController.titleText = "학과 선택"
            departmentSelectViewController.style = .mentee
            vc = departmentSelectViewController
        } else { vc = UIViewController() }
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 30
            sheet.prefersGrabberVisible = true
       }
       present(vc, animated: true)
    }
    
    // 직무선택 뷰컨트롤러 화면이 사라질 때 선택한 직무 데이터를 받음
    func didJobSelectViewControllerDismiss(elements: [String], selectedElements: [Int]) {
        // 선택한 데이터가 0개 이상일 때만 데이터 저장 및 뷰 수정
        if selectedElements.count > 0 {
            // 이 뷰컨트롤러에 데이터 저장하는 코드 추가해야 됨
            var selectedElementString: String = ""
            for selectedElement in selectedElements {
                print(elements[selectedElement])
                selectedElementString += (elements[selectedElement]+", ")
            }
            selectedElementString = String(selectedElementString.dropLast(2))
            
            jobTextField.textField.text = selectedElementString
        }
        
    }
    
    // 학과선택 뷰컨트롤러 화면이 사라질 때 선택한 학과 데이터를 받음
    func didDepartmentSelectViewControllerDismiss(elements: [String], selectedElements: [Int]) {
        // 선택한 데이터가 0개 이상일 때만 데이터 저장 및 뷰 수정
        if selectedElements.count > 0 {
            // 이 뷰컨트롤러에 데이터 저장하는 코드 추가해야 됨
            var selectedElementString: String = ""
            for selectedElement in selectedElements {
                print(elements[selectedElement])
                selectedElementString += (elements[selectedElement]+", ")
            }
            selectedElementString = String(selectedElementString.dropLast(2))
            
            departmentTextField.textField.text = selectedElementString
        }
        
    }
    
}

