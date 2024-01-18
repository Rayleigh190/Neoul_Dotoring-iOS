//
//  MyInfoEditViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/16/24.
//

import UIKit

class MyInfoEditViewController: UIViewController {
    var myPageView: MyPageView!
    
    // Data
    var fieldList = Fields(fields: [])
    var majorList = Majors(majors: [])
    var selectedFieldElements: [Int] = []
    var selectedMajorElements: [Int] = []
    
    var isChanged = false
    var isMyInfoChanged = false
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setAddTarget()
        setDelegate()
    }
    
    override func loadView() {
        super.loadView()
        myPageView = MyPageView(isEditable: true)
        self.view = myPageView
    }
    
    func setupNavigationController() {
        navigationItem.title = "내 정보 수정"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .BaseGray900
    }
    
    func setAddTarget() {
        myPageView.fieldButton.addTarget(self, action: #selector(selectTextFieldTapped), for: .touchUpInside)
        myPageView.departmentButton.addTarget(self, action: #selector(selectTextFieldTapped), for: .touchUpInside)
        myPageView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        myPageView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        myPageView.schoolTextField.addTarget(self, action: #selector(textFieldDidChanacge), for: .editingChanged)
        myPageView.fieldTextField.addTarget(self, action: #selector(textFieldDidChanacge), for: .editingChanged)
        myPageView.gradeTextField.addTarget(self, action: #selector(textFieldDidChanacge), for: .editingChanged)
        myPageView.departmentTextField.addTarget(self, action: #selector(textFieldDidChanacge), for: .editingChanged)
        myPageView.tagTextField1.textField.addTarget(self, action: #selector(textFieldDidChanacge), for: .editingChanged)
        myPageView.tagTextField2.textField.addTarget(self, action: #selector(textFieldDidChanacge), for: .editingChanged)
        myPageView.tagTextField3.textField.addTarget(self, action: #selector(textFieldDidChanacge), for: .editingChanged)
    }
    
    func setDelegate() {
        myPageView.schoolTextField.delegate = self
        myPageView.fieldTextField.delegate = self
        myPageView.gradeTextField.delegate = self
        myPageView.departmentTextField.delegate = self
        myPageView.tagTextField1.textField.delegate = self
        myPageView.tagTextField2.textField.delegate = self
        myPageView.tagTextField3.textField.delegate = self
    }

}

extension MyInfoEditViewController {
    @objc func cancelButtonTapped(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func doneButtonTapped(sender: UIButton) {
        if isMyInfoChanged {
            checkInputValue()
            showAlert(
                alertType: .canCancel,
                alertText: "학교, 분야, 학년 학과 수정 시\n새로운 증빙서류가 요청됩니다.\n계속하시겠습니까?",
                highlightText: "새로운 증빙서류",
                contentFontSieze: .small,
                hasSecondaryText: true,
                secondaryText: "승인에 최대 3일의 시간이 소요됩니다.",
                cancelButtonText: "아니오",
                confirmButtonText: "네",
                confirmButtonHighlight: true
            )
        } else {
            // 태그만 수정 했을때
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    func checkInputValue() {
        if myPageView.schoolTextField.text?.count == 0
            || myPageView.gradeTextField.text?.count == 0
            || myPageView.fieldTextField.text?.count == 0
            || myPageView.departmentTextField.text?.count == 0
        {
            Alert.showAlert(title: "안내", message: "입력되지 않은 값이 있습니다.")
            return
        }
        
        if let gradeStr =  myPageView.gradeTextField.text {
            let gradeInt = Int(gradeStr)!
            if gradeInt > 4 || gradeInt < 1 {
                Alert.showAlert(title: "안내", message: "학년은 1~4만 입력 가능합니다.")
            }
        }
    }
}

extension MyInfoEditViewController: SelectViewControllerDelegate {
    func didSelectViewControllerDismiss(elements: [String], selectedElements: [Int], sender: UIButton) {
        print(selectedElements)
        isChanged = true
        // 선택한 데이터가 0개 이상일 때만 데이터 저장 및 뷰 수정
        if selectedElements.count > 0 {
            // 뷰에 선택한 데이터 문자열 세팅
            var selectedElementString: String = ""
            for selectedElement in selectedElements {
                print(elements[selectedElement])
                selectedElementString += (elements[selectedElement]+", ")
            }
            selectedElementString = String(selectedElementString.dropLast(2))
            
            if sender == myPageView.fieldButton { // 멘토링분야 선택일 때
                // 이 뷰컨트롤러에 선택한 데이터 저장하는 코드
                self.selectedFieldElements = selectedElements
                myPageView.fieldTextField.text = selectedElementString
                textFieldDidEndEditing(myPageView.fieldTextField) // 텍스트필드 편집완료 실행
            } else { // 학과 선택일 때
                self.selectedMajorElements = selectedElements
                myPageView.departmentTextField.text = selectedElementString
                textFieldDidEndEditing(myPageView.departmentTextField) // 텍스트필드 편집완료 실행
            }
            
        } else {
            if sender == myPageView.fieldButton { // 멘토링분야 선택일 때
                selectedFieldElements = []
                myPageView.fieldTextField.text = ""
                textFieldDidEndEditing(myPageView.fieldTextField) // 텍스트필드 편집완료 실행
            } else { // 학과 선택일 때
                selectedMajorElements = []
                myPageView.departmentTextField.text = ""
                textFieldDidEndEditing(myPageView.departmentTextField) // 텍스트필드 편집완료 실행
            }
        }
        return
    }
    
    @objc func selectTextFieldTapped(sender: UIButton) {
        let vc = SelectViewController()
        if sender == myPageView.fieldButton {
            vc.selectViewControllerDelegate = self
            vc.titleText = "멘토링 분야 선택"
            vc.style = uiStyle
            vc.elements = ["1", "2"]
            vc.previousSelectedElements = []
        } else if sender == myPageView.departmentButton {
            vc.selectViewControllerDelegate = self
            vc.titleText = "학과 선택"
            vc.style = uiStyle
            vc.elements = ["1", "2"]
            vc.previousSelectedElements = []
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
}

extension MyInfoEditViewController: UITextFieldDelegate {
    @objc func textFieldDidChanacge(_ sender: UITextField?) {
        isChanged = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == myPageView.schoolTextField
            || textField == myPageView.fieldTextField
            || textField == myPageView.gradeTextField
            || textField == myPageView.departmentTextField {
            isMyInfoChanged = true
        }
        
        if isChanged {
            if uiStyle == .mento {
                myPageView.doneButton.setupButton(style: .green)
            } else {
                myPageView.doneButton.setupButton(style: .navy)
            }
            myPageView.doneButton.isEnabled = true
        }
    }
}

extension MyInfoEditViewController: CustomAlertDelegate {
    func action() {
        let vc = UploadDocumentsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func exit() {
        return
    }
    
    
}
