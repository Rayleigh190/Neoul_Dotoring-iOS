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
    var selectedFileURL2: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setNavigationItems()
    }
    
    override func loadView() {
        super.loadView()
        
        uploadDocumentsView = UploadDocumentsView(frame: self.view.frame)
        
        // Set the button action handler
        uploadDocumentsView.groupCertificateUploadButtonActionHandler = { [weak self] in
            self?.certificateOfEmploymentUploadButtonTapped()
        }
        uploadDocumentsView.graduateCertificateUploadButtonActionHandler = { [weak self] in
            self?.graduateCertificateUploadButtonActionHandler()
        }
        uploadDocumentsView.nextButtonActionHandler = { [weak self] in
            self?.nextButtonTapped()
        }

        self.view = uploadDocumentsView
    }

}

extension UploadDocumentsViewController {
    
    private func setNavigationItems() {
        navigationItem.title = "증빙서류 업로드"
        navigationController?.navigationBar.topItem?.backButtonTitle = "마이페이지"
        navigationController?.navigationBar.tintColor = .label
        
    }
    
    // sender : 0과 1
    func certificateOfEmploymentUploadButtonTapped() {
        // 재직증명서 업로드
        openPdfOrImgFile(sender: 0)
    }
    
    func graduateCertificateUploadButtonActionHandler() {
        // 졸업증명서 업로드
        openPdfOrImgFile(sender: 1)
    }
    
    func nextButtonTapped() {
        let vc = Signup3ViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
}

extension UploadDocumentsViewController: UIDocumentPickerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func openPdfOrImgFile(sender: Int) {
        let actionSheet = UIAlertController(title: "Select File Type", message: "Choose a file type to import", preferredStyle: .actionSheet)
        
        let pdfAction = UIAlertAction(title: "PDF", style: .default) { (action) in
            self.pickPDF(sender: sender)
        }
        
        let imageAction = UIAlertAction(title: "Image", style: .default) { (action) in
            self.pickImage(sender: sender)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(pdfAction)
        actionSheet.addAction(imageAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func pickPDF(sender: Int) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf], asCopy: true)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        if sender == 0 {
            documentPicker.view.tag = uploadDocumentsView.groupCertificateUploadButton.tag
        } else {
            documentPicker.view.tag = uploadDocumentsView.graduateCertificateUploadButton.tag
        }
        
        present(documentPicker, animated: true, completion: nil)
    }

    func pickImage(sender: Int) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        if sender == 0 { // 재직증명서 버튼일 경우
            imagePicker.view.tag = uploadDocumentsView.groupCertificateUploadButton.tag
        } else if sender == 1 { // 졸업증명서 버튼일 경우
            imagePicker.view.tag = uploadDocumentsView.graduateCertificateUploadButton.tag
        }
        present(imagePicker, animated: true, completion: nil)
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let selectedPDFURL = urls.first {
            if controller.view.tag == uploadDocumentsView.groupCertificateUploadButton.tag {
                selectedFileURL = selectedPDFURL
                uploadDocumentsView.groupCertificateUploadButton.setTitle(selectedPDFURL.lastPathComponent, for: .normal)
            } else if controller.view.tag == uploadDocumentsView.graduateCertificateUploadButton.tag {
                selectedFileURL2 = selectedPDFURL
                uploadDocumentsView.graduateCertificateUploadButton.setTitle(selectedPDFURL.lastPathComponent, for: .normal)
            }
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                if picker.view.tag == uploadDocumentsView.groupCertificateUploadButton.tag {
                    selectedFileURL = imageURL
                    uploadDocumentsView.groupCertificateUploadButton.setTitle(imageURL.lastPathComponent, for: .normal)
                } else if picker.view.tag == uploadDocumentsView.graduateCertificateUploadButton.tag {
                    selectedFileURL2 = imageURL
                    uploadDocumentsView.graduateCertificateUploadButton.setTitle(imageURL.lastPathComponent, for: .normal)
                }
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
