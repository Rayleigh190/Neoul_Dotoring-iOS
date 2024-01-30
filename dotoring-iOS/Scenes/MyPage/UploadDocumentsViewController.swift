//
//  UploadDocumentsViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/02.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class UploadDocumentsViewController: UIViewController {
    var myData: SignupData = SignupData()
    var uploadDocumentsView: UploadDocumentsView!

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
        setNavigationItems()
        setAddTarget()
    }
    
    override func loadView() {
        super.loadView()
        
        uploadDocumentsView = UploadDocumentsView(frame: self.view.frame)
        
        uploadDocumentsView.certificateUploadButtonActionHandler = { [weak self] in
            self?.certificateOfEmploymentUploadButtonTapped()
        }

        self.view = uploadDocumentsView
    }

}

extension UploadDocumentsViewController {
    
    private func setNavigationItems() {
        navigationItem.title = "증빙서류 업로드"
        navigationController?.navigationBar.tintColor = .label
    }
    
    func setAddTarget() {
        uploadDocumentsView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        uploadDocumentsView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    // sender : 0과 1
    func certificateOfEmploymentUploadButtonTapped() {
        // 재학증명서 업로드
        openPdfOrImgFile(sender: 0)
    }
    
    func deleteUserAccountInfo() {
        // 자동 로그인 id, pw 삭제
        if let _ = KeyChain.read(key: KeyChainKey.userID) {
            KeyChain.delete(key: KeyChainKey.userID)
            KeyChain.delete(key: KeyChainKey.userPW)
            print("UploadDocumentsViewController - deleteUserAccountInfo() : ID, PW 삭제 완료")
        }
        // 인증, 재인증 토큰 삭제
        if let _ = KeyChain.read(key: KeyChainKey.accessToken) {
            KeyChain.delete(key: KeyChainKey.accessToken)
            print("UploadDocumentsViewController - deleteUserAccountInfo() : accessToken 삭제 완료")
        }
    }
    
    @objc func cancelButtonTapped(sender: UIButton) {
        let vc = self.navigationController!.viewControllers
        self.navigationController?.popToViewController(vc[vc.count - 3 ], animated: true)
    }
    
    @objc func saveButtonTapped(sender: UIButton) {
        print("UploadDocumentsViewController - saveButtonTapped() called")
        self.deleteUserAccountInfo()
        
        let loginVC = LoginViewController()
        loginVC.isFromMyPage = true

        let vc = UINavigationController(rootViewController: loginVC)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
        // 내 정보 수정 요청
//        self.navigationController?.popToRootViewController(animated: true)
//        MyPageNetworkService.putMyInfo(uiStyle: uiStyle, myData: myData) { response, error in
//            if error != nil {
//                print("내 정보 수정 요청 오류 발생: \(error?.asAFError?.responseCode ?? 0)")
//                if let statusCode = error?.asAFError?.responseCode {
//                    Alert.showAlert(title: "내 정보 수정 요청 오류 발생", message: "\(statusCode)")
//                } else {
//                    Alert.showAlert(title: "내 정보 수정 요청 오류 발생", message: "네트워크 연결을 확인하세요.")
//                }
//            } else{
//                if response?.success == true {
//                    print(response!)
//                    // 로그아웃 및 로그인 화면으로 이동, 승인 대기
//                    self.deleteUserAccountInfo()
//                    
//                    let loginVC = LoginViewController()
//                    loginVC.isFromMyPage = true
//
//                    let vc = UINavigationController(rootViewController: loginVC)
//                    vc.modalTransitionStyle = .crossDissolve
//                    vc.modalPresentationStyle = .fullScreen
//                    self.present(vc, animated: true)
//                } else {
//                    Alert.showAlert(title: "오류", message: "알 수 없는 오류입니다. 다시 시도해 주세요. code : \(response?.error?.code ?? "0")")
//                }
//            }
//        }
    }
    
    func activeNextButton() {
        // 다음버튼 활성화
        uploadDocumentsView.saveButton.isEnabled = true
        uploadDocumentsView.saveButton.setTitleColor(.white, for: .normal)
        if uiStyle == .mento {
            uploadDocumentsView.saveButton.backgroundColor = .BaseGreen
        } else {
            uploadDocumentsView.saveButton.backgroundColor = .BaseNavy
        }
    }
}

extension UploadDocumentsViewController: UIDocumentPickerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func openPdfOrImgFile(sender: Int) {
        let actionSheet = UIAlertController(title: "파일 유형 선택", message: "파일 유형을 선택하세요", preferredStyle: .actionSheet)
        
        let pdfAction = UIAlertAction(title: "PDF", style: .default) { (action) in
            self.pickPDF(sender: sender)
        }
        
        let imageAction = UIAlertAction(title: "이미지", style: .default) { (action) in
            self.pickImage(sender: sender)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheet.addAction(pdfAction)
        actionSheet.addAction(imageAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func pickPDF(sender: Int) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf], asCopy: true)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        documentPicker.view.tag = uploadDocumentsView.certificateUploadButton.tag
        present(documentPicker, animated: true, completion: nil)
    }

    func pickImage(sender: Int) {
        self.view.makeToastActivity(.center)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.view.tag = uploadDocumentsView.certificateUploadButton.tag
        present(imagePicker, animated: true, completion: nil)
        self.view.hideToastActivity()
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let selectedPDFURL = urls.first {
            myData.certificationsFileURL = selectedPDFURL
            uploadDocumentsView.certificateUploadButton.setTitle(selectedPDFURL.lastPathComponent, for: .normal)
            myData.isDoc = true
            // 다음버튼 활성화
            activeNextButton()
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                myData.certificationsFileURL = imageURL
                uploadDocumentsView.certificateUploadButton.setTitle(imageURL.lastPathComponent, for: .normal)
                myData.isDoc = false
                // 다음버튼 활성화
                activeNextButton()
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
