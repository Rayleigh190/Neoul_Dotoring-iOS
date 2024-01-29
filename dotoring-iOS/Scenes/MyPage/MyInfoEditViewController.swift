//
//  MyInfoEditViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/16/24.
//

import UIKit

class MyInfoEditViewController: UIViewController {
    var myPageView: MyPageView!
    var myInfo: MyPage?
    
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
        updateUI()
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
    
    func updateUI() {
        for tagTextField in myPageView.tagTextFields {
            tagTextField.isHidden = false
        }
        guard let myInfo = myInfo else {return}
        myPageView.schoolTextField.text = myInfo.school
        myPageView.fieldTextField.text = myInfo.fields.joined(separator: ", ")
        myPageView.gradeTextField.text = String(myInfo.grade)
        myPageView.departmentTextField.text = myInfo.majors.joined(separator: ", ")
        for (i, tag) in myInfo.tags.enumerated() {
            let tagTextField = myPageView.tagTextFields[i]
            tagTextField.textField.text = tag
        }
        
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
        myPageView.tagTextField1.button.addTarget(self, action: #selector(removeTag), for: .touchUpInside)
        myPageView.tagTextField2.button.addTarget(self, action: #selector(removeTag), for: .touchUpInside)
        myPageView.tagTextField3.button.addTarget(self, action: #selector(removeTag), for: .touchUpInside)
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
            var tags: [String] = []
            for tagTextField in myPageView.tagTextFields {
                guard let text = tagTextField.textField.text else {return}
                if text.first == "#" && text.count > 1 {
                    tags.append(text)
                }
            }
            print("입력 태그 : \(tags)")
            MyPageNetworkService.patchTags(uiStyle: uiStyle, tags: tags) { response, error in
                if error != nil {
                    print("태그 수정 요청 오류 발생: \(error?.asAFError?.responseCode ?? 0)")
                    if let statusCode = error?.asAFError?.responseCode {
                        Alert.showAlert(title: "태그 수정 요청 오류 발생", message: "\(statusCode)")
                    } else {
                        Alert.showAlert(title: "태그 수정 요청 오류 발생", message: "네트워크 연결을 확인하세요.")
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
            if gradeInt > 4 || gradeInt < 1 || gradeStr.count > 1 {
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
        if sender == myPageView.fieldButton {
            let vc = SelectViewController(titleText: "멘토링 분야 선택", style: uiStyle, sender: sender, elements: ["1", "2"], previousSelectedElements: [], delegate: self)
            presentSheetPresentationController(vc: vc)
        } else if sender == myPageView.departmentButton {
            let vc = SelectViewController(titleText: "학과 선택", style: uiStyle, sender: sender, elements: ["1", "2"], previousSelectedElements: [], delegate: self)
            presentSheetPresentationController(vc: vc)
        }
    }
    
    func presentSheetPresentationController(vc: UIViewController) {
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
    
    @objc func removeTag(sender: UIButton) {
        isChanged = true
        if sender.tag == 1 {
            myPageView.tagTextField1.textField.text = ""
            textFieldDidEndEditing(myPageView.tagTextField1.textField)
        } else if sender.tag == 2 {
            myPageView.tagTextField2.textField.text = ""
            textFieldDidEndEditing(myPageView.tagTextField2.textField)
        } else if sender.tag == 3 {
            myPageView.tagTextField3.textField.text = ""
            textFieldDidEndEditing(myPageView.tagTextField3.textField)
        }
    }
    
    // 태그 작성 시작 시 맨 앞에 #을 지워줍니다.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == myPageView.tagTextField1.textField
            || textField == myPageView.tagTextField2.textField
            || textField == myPageView.tagTextField3.textField {
            if let text = textField.text, text.hasPrefix("#") {
                textField.text = NSMutableString(string: text).substring(from: 1)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == myPageView.schoolTextField
            || textField == myPageView.fieldTextField
            || textField == myPageView.gradeTextField
            || textField == myPageView.departmentTextField {
            isMyInfoChanged = true
        }
        
        // 태그 작성 완료 시 맨 앞에 #을 붙여줍니다.
        if textField == myPageView.tagTextField1.textField
            || textField == myPageView.tagTextField2.textField
            || textField == myPageView.tagTextField3.textField {
            if textField.text?.first != "#" {
                guard let text = textField.text else {return}
                textField.text = "#" + text
            }
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
    
    // tag textField 글자수 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == myPageView.tagTextField1.textField
            || textField == myPageView.tagTextField2.textField
            || textField == myPageView.tagTextField3.textField {
            let inputString = string.trimmingCharacters(in: .whitespacesAndNewlines)
            guard let oldString = textField.text, let newRange = Range(range, in: oldString) else { return true }
            let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)

            let characterCount = newString.count
            
            guard characterCount <= 6 else {
                print(characterCount)
                self.view.makeToast("6자 이하까지 작성 가능합니다.", duration: 1, position: .top)
                return false
            }
        }
        return true
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
