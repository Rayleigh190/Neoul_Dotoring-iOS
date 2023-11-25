//
//  ChatViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/25/23.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import Photos

class ChatViewController: MessagesViewController {
    
//    lazy var cameraBarButtonItem: InputBarButtonItem = {
//        let button = InputBarButtonItem(type: .system)
//        button.tintColor = .blue
//        button.image = UIImage(systemName: "camera")
//        button.addTarget(self, action: #selector(didTapCameraButton), for: .touchUpInside)
//        return button
//    }()
    
    let channel: Channel
    var sender = Sender(senderId: "any_unique_id", displayName: "jake")
    var messages = [Message]()
    
    private var isSendingPhoto = false {
      didSet {
        messageInputBar.leftStackViewItems.forEach { item in
          guard let item = item as? InputBarButtonItem else {
            return
          }
          item.isEnabled = !self.isSendingPhoto
        }
      }
    }
    
    init(channel: Channel) {
      self.channel = channel
      super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmDelegates()
        configure()
        setupMessageInputBar()
        removeOutgoingMessageAvatars() // 이게 뭐지?
//        addCameraBarButtonToMessageInputBar()
    }
    
    deinit {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func confirmDelegates() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messageInputBar.delegate = self
    }
    
    private func configure() {
//        title = channel.name
        title = "닉네임"
        navigationController?.navigationBar.prefersLargeTitles = false
        messages = getMessagesMock()
        messagesCollectionView.reloadData()
    }
    
    private func setupMessageInputBar() {
//        messageInputBar.inputTextView.tintColor = .
        messageInputBar.sendButton.setTitleColor(.BaseGreen, for: .normal)
        messageInputBar.inputTextView.placeholder = "내용"
    }
    
    private func removeOutgoingMessageAvatars() {
        guard let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout else { return }
        layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
        layout.setMessageOutgoingAvatarSize(.zero)
        let outgoingLabelAlignment = LabelAlignment(textAlignment: .right, textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15))
        layout.setMessageOutgoingMessageTopLabelAlignment(outgoingLabelAlignment)
    }
    
//    private func addCameraBarButtonToMessageInputBar() {
//        messageInputBar.leftStackView.alignment = .center
//        messageInputBar.setLeftStackViewWidthConstant(to: 50, animated: false)
//        messageInputBar.setStackViewItems([cameraBarButtonItem], forStack: .left, animated: false)
//    }
    
    private func insertNewMessage(_ message: Message) {
        messages.append(message)
        messages.sort()
        
        messagesCollectionView.reloadData()
    }
    
//    @objc private func didTapCameraButton() {
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            picker.sourceType = .camera
//        } else {
//            picker.sourceType = .photoLibrary
//        }
//        present(picker, animated: true)
//    }
}

extension ChatViewController: MessagesDataSource {
//    var currentSender: MessageKit.SenderType {
//        return sender
//    }
    
    var currentSender: SenderType {
        return Sender(senderId: "1", displayName: "Steven")
    }
    
//    func currentSender() -> SenderType {
//        return sender
//    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [.font: UIFont.preferredFont(forTextStyle: .caption1),
                                                             .foregroundColor: UIColor(white: 0.3, alpha: 1)])
    }
}

extension ChatViewController: MessagesLayoutDelegate {
    // 아래 여백
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 8)
    }
    
    // 말풍선 위 이름 나오는 곳의 height
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
}

// 상대방이 보낸 메시지, 내가 보낸 메시지를 구분하여 색상과 모양 지정
extension ChatViewController: MessagesDisplayDelegate {
    // 말풍선의 배경 색상
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .blue : .green
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .black : .white
    }
    
    // 말풍선의 꼬리 모양 방향
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let cornerDirection: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(cornerDirection, .curved)
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = Message(content: text, senderID: "1")
        
        // TODO
//        saveMessageAndScrollToLastItem(message)
        
        insertNewMessage(message)
        inputBar.inputTextView.text.removeAll()
    }
}

//extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true)
//        
//        if let asset = info[.phAsset] as? PHAsset {
//            let imageSize = CGSize(width: 500, height: 500)
//            PHImageManager.default().requestImage(for: asset,
//                                                     targetSize: imageSize,
//                                                     contentMode: .aspectFit,
//                                                     options: nil) { image, _ in
//                guard let image = image else { return }
//                self.sendPhoto(image)
//            }
//        } else if let image = info[.originalImage] as? UIImage {
//            sendPhoto(image)
//        }
//    }
//    
//    private func sendPhoto(_ image: UIImage) {
//        isSendingPhoto = true
//        // TODO: upload to firebase
//        isSendingPhoto = false
//        let message = Message(image: image)
//        insertNewMessage(message)
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true)
//    }
//}
