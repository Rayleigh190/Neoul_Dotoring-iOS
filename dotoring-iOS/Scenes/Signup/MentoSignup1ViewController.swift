//
//  MentoSignup1ViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/01.
//

import UIKit

class MentoSignup1ViewController: UIViewController {
    
    // 뷰 전체 높이 길이
    let screenHeight = UIScreen.main.bounds.size.height
    
    // Data
    var fieldList = Fields(fields: [])
    var majorList = Majors(majors: [])
    var selectedFieldElements: [Int] = []
    var selectedMajorElements: [Int] = []
    
    private lazy var stepBar: SignupStepBar = {
        let bar = SignupStepBar(stepCount: 6, currentStep: 1, style: .mento)
        
        return bar
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 24)
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
        label.text = "멘토입니다."
        
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
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        self.hideKeyboardWhenTappedAround()
        setupSubViews()
        setupUI()
        fetchFieldList()
        fetchMajorList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // textField 입력 넘칠 때 늘어나는 현상 방지
        schoolTextField.snp.makeConstraints {
            $0.width.equalTo(schoolTextField.frame.width).priority(.required)
        }
    }
    
    func checkInputValue() {
        if schoolTextField.textField.text?.count == 0
            || gradeTextField.textField.text?.count == 0
            || fieldTextField.textField.text?.count == 0
            || departmentTextField.textField.text?.count == 0
        {
            Alert.showAlert(title: "안내", message: "입력되지 않은 값이 있습니다.")
            return
        }
        
        if let gradeStr =  gradeTextField.textField.text {
            let gradeInt = Int(gradeStr)!
            if gradeInt > 4 || gradeInt < 0 {
                Alert.showAlert(title: "안내", message: "학년은 1~4만 입력 가능합니다.")
            }
        }
    }
    
    @objc func nextButtonTapped(sender: UIButton!) {
        checkInputValue()
        guard let school = schoolTextField.textField.text else {return}
        guard let grade = Int(gradeTextField.textField.text!) else {return}
        var fields:[String] = []
        var majors:[String] = []
        for index in selectedFieldElements {
            fields.append(fieldList.fields[index])
        }
        for index in selectedMajorElements {
            majors.append(majorList.majors[index])
        }
        
        let vc = Signup2ViewController()
        vc.school = school
        vc.grade = grade
        vc.fields = fields
        vc.majors = majors
        navigationController?.pushViewController(vc, animated: false)
    }

}

private extension MentoSignup1ViewController {
    
    func setupUI() {
        self.navigationController?.navigationBar.tintColor = .BaseGray700
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let titleLabel = UILabel()
        titleLabel.text = "멘토로 회원가입"
        titleLabel.textColor = UIColor.label // 전체 글씨 색상
        titleLabel.font = .nanumSquare(style: .NanumSquareOTFR, size: 15)
        titleLabel.sizeToFit()

        let mentorRange = (titleLabel.text! as NSString).range(of: "멘토")
        let attributedString = NSMutableAttributedString(string: titleLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.BaseGreen!, range: mentorRange)

        titleLabel.attributedText = attributedString

        self.navigationItem.titleView = titleLabel
    
    }
    
    func setupSubViews() {
        
        [stepBar, titleLabel, nextButton, fieldTextFieldButton, departmentTextFieldButton].forEach {view.addSubview($0)}
        
        [content1Label, content2Label, content3Label, content4Label, content5Label, content6Label].forEach {view.addSubview($0)}
        
        [schoolTextField, gradeTextField, fieldTextField, departmentTextField].forEach {view.addSubview($0)}
        
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
            $0.top.equalTo(stepBar.snp.bottom).offset(20)
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
        
        fieldTextField.snp.makeConstraints {
            $0.centerX.equalTo(gradeTextField)
            $0.top.equalTo(gradeTextField.snp.bottom).offset(20)
            $0.leading.equalTo(gradeTextField.snp.leading)
        }
        
        content4Label.snp.makeConstraints {
            $0.centerY.equalTo(fieldTextField)
            $0.leading.equalTo(content3Label.snp.leading)
        }
        
        content5Label.snp.makeConstraints {
            $0.leading.equalTo(content1Label.snp.leading).offset(25)
            $0.top.equalTo(fieldTextField.snp.bottom).offset(26)
        }
        
        departmentTextField.snp.makeConstraints {
            $0.centerX.equalTo(fieldTextField)
            $0.top.equalTo(content5Label.snp.bottom).offset(15)
            $0.leading.equalTo(fieldTextField.snp.leading)
        }
        
        content6Label.snp.makeConstraints {
            $0.centerY.equalTo(departmentTextField)
            $0.leading.equalTo(content4Label.snp.leading)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(departmentTextField.snp.bottom).offset(55)
            $0.height.equalTo(48)
            $0.bottom.lessThanOrEqualToSuperview().inset(20).priority(.required)
        }
        
        fieldTextFieldButton.snp.makeConstraints {
            $0.width.height.equalTo(fieldTextField)
            $0.centerX.centerY.equalTo(fieldTextField)
        }
        
        departmentTextFieldButton.snp.makeConstraints {
            $0.width.height.equalTo(departmentTextField)
            $0.centerX.centerY.equalTo(departmentTextField)
        }
        
    }
}

// Network
extension MentoSignup1ViewController {
    
    func fetchFieldList() {
        SignupNetworkService
            .fetchFieldList() { response, error in
                if error != nil {
                    // 멘토링 분야 요청 에러 발생
                    print("멘토링 분야 요청 에러 발생 : \(error?.asAFError?.responseCode ?? 0)")
                    if let statusCode = error?.asAFError?.responseCode {
                        Alert.showAlert(title: "멘토링 분야 요청 에러 발생", message: "\(statusCode)")
                    } else {
                        Alert.showAlert(title: "멘토링 분야 요청 에러 발생", message: "네트워크 연결을 확인하세요.")
                    }
                } else {
                    if response?.success == true {
                        debugPrint(response!)
                        guard let fields = response?.response else {return}
                        self.fieldList = fields
                    } else {
                        Alert.showAlert(title: "오류", message: "알 수 없는 오류입니다. 다시 시도해 주세요. code : \(response?.error?.code ?? "0")")
                    }
                }
            }
    }
    
    func fetchMajorList() {
        SignupNetworkService
            .fetchMajorList() { response, error in
                if error != nil {
                    // 학과 요청 에러 발생
                    print("학과 요청 에러 발생 : \(error?.asAFError?.responseCode ?? 0)")
                    if let statusCode = error?.asAFError?.responseCode {
                        Alert.showAlert(title: "학과 요청 에러 발생", message: "\(statusCode)")
                    } else {
                        Alert.showAlert(title: "학과 요청 에러 발생", message: "네트워크 연결을 확인하세요.")
                    }
                } else {
                    if response?.success == true {
                        debugPrint(response!)
                        guard let majors = response?.response else {return}
                        self.majorList = majors
                    } else {
                        Alert.showAlert(title: "오류", message: "알 수 없는 오류입니다. 다시 시도해 주세요. code : \(response?.error?.code ?? "0")")
                    }
                }
            }
    }
    
}

extension MentoSignup1ViewController: SelectViewControllerDelegate {
    
    @objc private func selectTextFieldTapped(sender: UIButton) {
        let vc = SelectViewController()
        if sender == fieldTextFieldButton {
            vc.selectViewControllerDelegate = self
            vc.titleText = "멘토링 분야 선택"
            vc.style = .mento
            vc.elements = fieldList.fields
            vc.previousSelectedElements = selectedFieldElements
        } else if sender == departmentTextFieldButton {
            vc.selectViewControllerDelegate = self
            vc.titleText = "학과 선택"
            vc.style = .mento
            vc.elements = majorList.majors
            vc.previousSelectedElements = selectedMajorElements
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
    
    // 분야선택, 학과선택 뷰컨트롤러 화면이 사라질 때 선택한 데이터를 받음
    func didSelectViewControllerDismiss(elements: [String], selectedElements: [Int], sender: UIButton) {
        // 선택한 데이터가 0개 이상일 때만 데이터 저장 및 뷰 수정
        if selectedElements.count > 0 {
            // 뷰에 선택한 데이터 문자열 세팅
            var selectedElementString: String = ""
            for selectedElement in selectedElements {
                print(elements[selectedElement])
                selectedElementString += (elements[selectedElement]+", ")
            }
            selectedElementString = String(selectedElementString.dropLast(2))
            
            if sender == fieldTextFieldButton { // 멘토링분야 선택일 때
                // 이 뷰컨트롤러에 선택한 데이터 저장하는 코드
                self.selectedFieldElements = selectedElements
                fieldTextField.textField.text = selectedElementString
            } else { // 학과 선택일 때
                self.selectedMajorElements = selectedElements
                departmentTextField.textField.text = selectedElementString
            }
            
        } else {
            if sender == fieldTextFieldButton { // 멘토링분야 선택일 때
                selectedFieldElements = []
                fieldTextField.textField.text = ""
            } else { // 학과 선택일 때
                selectedMajorElements = []
                departmentTextField.textField.text = ""
            }
        }
        
    }
    
}
