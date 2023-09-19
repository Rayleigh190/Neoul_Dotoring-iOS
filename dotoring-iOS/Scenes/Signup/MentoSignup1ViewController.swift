//
//  MentoSignup1ViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/01.
//

import UIKit

protocol JobSelectViewControllerDelegate: AnyObject {
    // 직무선택 뷰컨트롤러 화면이 사라질 때 선택한 직무 데이터를 받음
    func didJobSelectViewControllerDismiss(elements: [String], selectedElements: [Int])
}

class MentoSignup1ViewController: UIViewController {
    
    private lazy var navTitleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 14)
        let text = "멘토로 회원가입"
        label.text = text
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.BaseGreen!, range: (text as NSString).range(of: "멘토"))
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var stepBar: SignupStepBar = {
        let bar = SignupStepBar(stepCount: 6, currentStep: 1)
        
        return bar
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        let text = "Q. 멘토님은 어떤 분인가요?"
        label.text = text
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.BaseGreen!, range: (text as NSString).range(of: "멘토"))
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
        label.text = "에 소속된"
        
        return label
    }()
    
    private lazy var content3Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "년 차"
        
        return label
    }()
    
    private lazy var content4Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "입니다."
        
        return label
    }()
    
    private lazy var content5Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "저는 대학교에서"
        
        return label
    }()
    
    private lazy var content6Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "를 다녔어요."
        
        return label
    }()
    
    private lazy var companyTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.textAlignment = .center
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let centeredPlaceholder = NSAttributedString(string: "소속", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        lineTextField.textField.attributedPlaceholder = centeredPlaceholder
        
        return lineTextField
    }()
    
    private lazy var yearTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.textAlignment = .center
        lineTextField.textField.keyboardType = .numberPad
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let centeredPlaceholder = NSAttributedString(string: "연차", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        lineTextField.textField.attributedPlaceholder = centeredPlaceholder
        
        return lineTextField
    }()
    
    private lazy var jobTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.textAlignment = .center
        lineTextField.isUserInteractionEnabled = false

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let centeredPlaceholder = NSAttributedString(string: "직무", attributes: [
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
    
    private lazy var nextButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("다음", for: .normal)
//        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
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

}

private extension MentoSignup1ViewController {
    
    func setupSubViews() {
        
        [navTitleLabel, stepBar, titleLabel, nextButton, jobTextFieldButton, departmentTextFieldButton].forEach {view.addSubview($0)}
        
        [content1Label, content2Label, content3Label, content4Label, content5Label, content6Label].forEach {view.addSubview($0)}
        
        [companyTextField, yearTextField, jobTextField, departmentTextField].forEach {view.addSubview($0)}
        
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
        
        companyTextField.snp.makeConstraints {
            $0.centerY.equalTo(content1Label)
            $0.leading.equalTo(content1Label.snp.trailing).offset(17)
            $0.width.equalTo(100)
        }
        
        content2Label.snp.makeConstraints {
            $0.centerY.equalTo(companyTextField)
            $0.leading.equalTo(companyTextField.snp.trailing).offset(17)
        }
        
        yearTextField.snp.makeConstraints {
            $0.centerX.equalTo(companyTextField)
            $0.top.equalTo(companyTextField.snp.bottom).offset(20)
            $0.width.equalTo(100)
        }
        
        content3Label.snp.makeConstraints {
            $0.centerY.equalTo(yearTextField)
            $0.leading.equalTo(yearTextField.snp.trailing).offset(17)
        }
        
        jobTextField.snp.makeConstraints {
            $0.centerX.equalTo(yearTextField)
            $0.top.equalTo(yearTextField.snp.bottom).offset(20)
            $0.width.equalTo(100)
        }
        
        content4Label.snp.makeConstraints {
            $0.centerY.equalTo(jobTextField)
            $0.leading.equalTo(jobTextField.snp.trailing).offset(17)
        }
        
        content5Label.snp.makeConstraints {
            $0.leading.equalTo(content1Label.snp.leading).offset(25)
            $0.top.equalTo(jobTextField.snp.bottom).offset(26)
        }
        
        departmentTextField.snp.makeConstraints {
            $0.centerX.equalTo(jobTextField)
            $0.top.equalTo(content5Label.snp.bottom).offset(15)
            $0.width.equalTo(100)
        }
        
        content6Label.snp.makeConstraints {
            $0.centerY.equalTo(departmentTextField)
            $0.leading.equalTo(departmentTextField.snp.trailing).offset(17)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalTo(departmentTextField.snp.bottom).offset(54)
            $0.height.equalTo(45)
        }
        
        jobTextFieldButton.snp.makeConstraints {
            $0.width.height.equalTo(jobTextField)
            $0.centerX.centerY.equalTo(jobTextField)
        }
        
        departmentTextFieldButton.snp.makeConstraints {
            $0.width.height.equalTo(departmentTextField)
            $0.centerX.centerY.equalTo(departmentTextField)
        }
        
    }
}

extension MentoSignup1ViewController: JobSelectViewControllerDelegate {
    @objc private func selectTextFieldTapped(sender: UIButton) {
        var vc: UIViewController
        if sender == jobTextFieldButton {
            let jobSelectViewController = JobSelectViewController()
            jobSelectViewController.jobSelectViewControllerDelegate = self
            vc = jobSelectViewController
        } else if sender == departmentTextFieldButton {
            vc = DepartmentSelectViewController()
        } else { vc = UIViewController() }
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 30
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
}
