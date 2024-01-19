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
    
    var uploadDocumentsView: UploadDocumentsView!
    var selectedFileURL: URL?

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
    
    @objc func cancelButtonTapped(sender: UIButton) {
        let vc = self.navigationController!.viewControllers
        self.navigationController?.popToViewController(vc[vc.count - 3 ], animated: true)
    }
    
    @objc func saveButtonTapped(sender: UIButton) {
        
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
            selectedFileURL = selectedPDFURL
            uploadDocumentsView.certificateUploadButton.setTitle(selectedPDFURL.lastPathComponent, for: .normal)
            // 다음버튼 활성화
            activeNextButton()
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                selectedFileURL = imageURL
                uploadDocumentsView.certificateUploadButton.setTitle(imageURL.lastPathComponent, for: .normal)
                // 다음버튼 활성화
                activeNextButton()
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
