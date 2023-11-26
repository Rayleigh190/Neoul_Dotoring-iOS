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
    
    let channel: Channel
//    var sender = Sender(senderId: "any_unique_id", displayName: "jake")
    let currentReceiver = Sender(senderId: "0", displayName: "홍길동")
    
    lazy var messages = [
        Message(messageId: "0", sender: currentReceiver, sentDate: Date(), content: "안녕하세요"),
        Message(messageId: "0", sender: currentReceiver, sentDate: Date(), content: "반갑습니다, 멘티님")
    ]
    
    let outgoingAvatarOverlap: CGFloat = 17.5

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
//        setupMessageInputBar()
        configureMessageInputBar()
        removeOutgoingMessageAvatars()
        setNavigationItems()
    }
    
    deinit {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setNavigationItems() {
        navigationController?.navigationBar.topItem?.backButtonTitle = "채팅 목록"
        navigationController?.navigationBar.tintColor = .BaseGray900
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    // 테스트를 위한 임시 버튼
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: UserDetailViewController.self, action: .none)
        let blockAction = UIAction(title: "오늘", image: UIImage(systemName: "nosign"), handler: blockButtonActionHandler)
        let reportAction = UIAction(title: "다음날", image: UIImage(systemName: "exclamationmark.bubble"), handler: reportButtonActionHandler)
        
        barButtonItem.menu = UIMenu(title: "",
                                    image: nil,
                                    identifier: nil,
                                    options: .displayInline,
                                    children: [blockAction, reportAction])
        
        return barButtonItem
    }()
    
    // 테스트용
    func blockButtonActionHandler(sender: UIAction!) {
        let message = Message(messageId: UUID().uuidString, sender: currentReceiver, sentDate: Date(), content: "안녕하세요")
        insertNewMessage(message)
    }
    
    // 테스트용
    func reportButtonActionHandler(sender: UIAction!) {
        let message = Message(messageId: UUID().uuidString, sender: currentReceiver, sentDate: Date(timeIntervalSinceNow:60*60*24), content: "안녕하세요")
        insertNewMessage(message)
    }

    private func confirmDelegates() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        
        messageInputBar.delegate = self
        
        showMessageTimestampOnSwipeLeft = true
    }
    
    private func configure() {
        updateTitleView(title: channel.name, subtitle: channel.major)
        navigationController?.navigationBar.prefersLargeTitles = false
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToLastItem(animated: false)
        
        // 악세사리뷰 설정(읽음 표시)
        let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout
//        layout?.sectionInset = UIEdgeInsets(top: 1, left: 8, bottom: 1, right: 5)
        layout?.setMessageIncomingAccessoryViewSize(CGSize(width: 6, height: 6))
//        layout?.setMessageIncomingAccessoryViewPadding(HorizontalEdgeInsets(left: 8, right: 0))
        layout?.setMessageIncomingAccessoryViewPosition(.messageBottom)
        layout?.setMessageOutgoingAccessoryViewSize(CGSize(width: 6, height: 6))
        layout?.setMessageOutgoingAccessoryViewPosition(.messageBottom)
//        layout?.setMessageOutgoingAccessoryViewPadding(HorizontalEdgeInsets(left: 0, right: 8))
        layout?
          .setMessageOutgoingMessageBottomLabelAlignment(LabelAlignment(
            textAlignment: .right,
            textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)))

    }
    
//    private func setupMessageInputBar() {
//        messageInputBar.sendButton.setTitle("", for: .normal)
//        messageInputBar.sendButton.setImage(UIImage(named: "MessageSendBtnImg"), for: .normal)
//        messageInputBar.inputTextView.placeholder = "메세지를 입력하세요."
//    }
    
    private func removeOutgoingMessageAvatars() {
        guard let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout else { return }
        layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
        layout.setMessageOutgoingAvatarSize(.zero)
        let outgoingLabelAlignment = LabelAlignment(textAlignment: .right, textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15))
        layout.setMessageOutgoingMessageTopLabelAlignment(outgoingLabelAlignment)
    }
    
    // MARK: - Helpers

    private func insertNewMessage(_ message: Message) {
        messages.append(message)
        messages.sort() // 이걸 빼야 하나
        
        messagesCollectionView.performBatchUpdates({
          messagesCollectionView.insertSections([messages.count - 1])
          if messages.count >= 2 {
            messagesCollectionView.reloadSections([messages.count - 2])
          }
        }, completion: { [weak self] _ in
          if self?.isLastSectionVisible() == true {
            self?.messagesCollectionView.scrollToLastItem(animated: true)
          }
        })
    }
    
    func isTimeLabelVisible(at indexPath: IndexPath) -> Bool {
        !isNextMessageSameDay(at: indexPath)
    }
    
    func isLastSectionVisible() -> Bool {
      guard !messages.isEmpty else { return false }
      let lastIndexPath = IndexPath(item: 0, section: messages.count - 1)
      return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
    
    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section - 1 >= 0 else { return false }
        return messages[indexPath.section].sender.senderId == messages[indexPath.section - 1].sender.senderId
    }
    
    func isNextMessageSameSender(at indexPath: IndexPath) -> Bool {
      guard indexPath.section + 1 < messages.count else { return false }
      return messages[indexPath.section].sender.senderId == messages[indexPath.section + 1].sender.senderId
    }
    
    func isNextMessageSameDay(at indexPath: IndexPath) -> Bool {
        guard indexPath.section - 1 >= 0 else { return false }
        let currentMessage = messages[indexPath.section]
        let previousMessage = messages[indexPath.section - 1]
        
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = [.year, .month, .day]
        
        let currentMessageDateComponents = calendar.dateComponents(components, from: currentMessage.sentDate)
        let previousMessageDateComponents = calendar.dateComponents(components, from: previousMessage.sentDate)
        return currentMessageDateComponents == previousMessageDateComponents
    }
    
    func isPreviousMessageSameDate(at indexPath: IndexPath) -> Bool {
        guard indexPath.section - 1 >= 0 else { return false }
        let currentMessage = messages[indexPath.section]
        let previousMessage = messages[indexPath.section - 1]
        
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute]
        
        let currentMessageDateComponents = calendar.dateComponents(components, from: currentMessage.sentDate)
        let previousMessageDateComponents = calendar.dateComponents(components, from: previousMessage.sentDate)
        return currentMessageDateComponents == previousMessageDateComponents
    }
    
    func isNextMessageSameDate(at indexPath: IndexPath) -> Bool {
        guard indexPath.section + 1 < messages.count else { return false }
        let currentMessage = messages[indexPath.section]
        let nextMessage = messages[indexPath.section  + 1]
        
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute]
        
        let currentMessageDateComponents = calendar.dateComponents(components, from: currentMessage.sentDate)
        let previousMessageDateComponents = calendar.dateComponents(components, from: nextMessage.sentDate)
        return currentMessageDateComponents == previousMessageDateComponents
    }
    
    // InputBar 관련 설정
    func configureMessageInputBar() {
        messageInputBar.delegate = self
//        messageInputBar.inputTextView.tintColor = .blue
//        messageInputBar.sendButton.setTitleColor(.blue, for: .normal)
//        messageInputBar.sendButton.setTitleColor(UIColor.blue.withAlphaComponent(0.3), for: .highlighted)

        messageInputBar.isTranslucent = true
        messageInputBar.separatorLine.isHidden = true
  //      messageInputBar.inputTextView.tintColor = .primaryColor
        messageInputBar.inputTextView.backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
        messageInputBar.inputTextView.placeholderTextColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        messageInputBar.inputTextView.placeholder = nil
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 36)
        messageInputBar.inputTextView.layer.borderColor = UIColor(red: 200 / 255, green: 200 / 255, blue: 200 / 255, alpha: 1).cgColor
        messageInputBar.inputTextView.layer.borderWidth = 1.0
        messageInputBar.inputTextView.layer.cornerRadius = 16.0
        messageInputBar.inputTextView.layer.masksToBounds = true
        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        configureInputBarItems()
        inputBarType = .custom(messageInputBar)
      }
      
      private func configureInputBarItems() {
        messageInputBar.setRightStackViewWidthConstant(to: 36, animated: false)
        messageInputBar.sendButton.imageView?.backgroundColor = UIColor(white: 0.85, alpha: 1)
        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        messageInputBar.sendButton.setSize(CGSize(width: 36, height: 36), animated: false)
        messageInputBar.sendButton.image = UIImage(named: "MessageSendBtnImg")
        messageInputBar.sendButton.title = nil
        messageInputBar.sendButton.imageView?.layer.cornerRadius = 16
        let charCountButton = InputBarButtonItem()
          .configure {
            $0.title = "0/140"
            $0.contentHorizontalAlignment = .right
            $0.setTitleColor(UIColor(white: 0.6, alpha: 1), for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
            $0.setSize(CGSize(width: 50, height: 25), animated: false)
          }.onTextViewDidChange { item, textView in
            item.title = "\(textView.text.count)/140"
            let isOverLimit = textView.text.count > 140
            item.inputBarAccessoryView?
              .shouldManageSendButtonEnabledState = !isOverLimit // Disable automated management when over limit
            if isOverLimit {
              item.inputBarAccessoryView?.sendButton.isEnabled = false
            }
            let color = isOverLimit ? .red : UIColor(white: 0.6, alpha: 1)
            item.setTitleColor(color, for: .normal)
          }
        let bottomItems = [.flexibleSpace, charCountButton]

        configureInputBarPadding()

        messageInputBar.setStackViewItems(bottomItems, forStack: .bottom, animated: false)

        // This just adds some more flare
//        messageInputBar.sendButton
//          .onEnabled { item in
//            UIView.animate(withDuration: 0.3, animations: {
//              item.imageView?.backgroundColor = .clear
//            })
//          }.onDisabled { item in
//            UIView.animate(withDuration: 0.3, animations: {
//              item.imageView?.backgroundColor = UIColor(white: 0.85, alpha: 1)
//            })
//          }
    }
    
    private func configureInputBarPadding() {
      // Entire InputBar padding
      messageInputBar.padding.bottom = 8

      // or MiddleContentView padding
      messageInputBar.middleContentViewPadding.right = -38

      // or InputTextView padding
      messageInputBar.inputTextView.textContainerInset.bottom = 8
    }
    
}

extension ChatViewController: MessagesDataSource {
    
    var currentSender: SenderType {
        return Sender(senderId: "1", displayName: "Steven")
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        let nsString = NSAttributedString(
                        string: name,
                        attributes: [.font: UIFont.preferredFont(forTextStyle: .caption1),
                                     .foregroundColor: UIColor(white: 0.3, alpha: 1)])
        
        if !isPreviousMessageSameDate(at: indexPath) && !isPreviousMessageSameSender(at: indexPath) {
            return nsString
        } else if !isPreviousMessageSameSender(at: indexPath) {
            return nsString
        } else if !isPreviousMessageSameDate(at: indexPath) && isPreviousMessageSameSender(at: indexPath) {
            return nsString
        }
        
        return nil
    }
    
    func formatTimeFromDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" // "HH:mm"은 24시간 형식, "hh:mm a"은 12시간 형식(오전/오후)
        return formatter.string(from: date)
    }

    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        let nsString = NSAttributedString(
                        string: formatTimeFromDate(message.sentDate),
                        attributes: [.font: UIFont.preferredFont(forTextStyle: .caption1),
                                     .foregroundColor: UIColor(white: 0.3, alpha: 1)])
        
        if !isNextMessageSameDate(at: indexPath){
            return nsString
        } else if !isNextMessageSameSender(at: indexPath) {
            return nsString
        }
        return nil
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR") // 한국 로케일 설정
        formatter.dateFormat = "yyyy년 M월 d일 EEEE" // 원하는 형식 설정
        return formatter.string(from: date)
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        let nsString = NSAttributedString(
                        string: formatDate(message.sentDate),
                        attributes: [.font: UIFont.preferredFont(forTextStyle: .caption1),
                                     .foregroundColor: UIColor(white: 0.3, alpha: 1)])
        
        if !isNextMessageSameDay(at: indexPath) {
            return nsString
        }
        return nil
    }
}

extension ChatViewController: MessagesLayoutDelegate {
    func cellTopLabelHeight(for _: MessageType, at indexPath: IndexPath, in _: MessagesCollectionView) -> CGFloat {
        if isTimeLabelVisible(at: indexPath) {
            return 18
        }
        return 0
    }
    
    // 말풍선 위 이름 나오는 곳의 height
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in _: MessagesCollectionView) -> CGFloat {
        if !isPreviousMessageSameDate(at: indexPath) && !isPreviousMessageSameSender(at: indexPath) {
            return 20
        } else if !isPreviousMessageSameSender(at: indexPath) {
            return 20
        } else if !isPreviousMessageSameDate(at: indexPath) && isPreviousMessageSameSender(at: indexPath) {
            return 20
        } else {
            return 0
        }
    }
    
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in _: MessagesCollectionView) -> CGFloat {
        if !isNextMessageSameDate(at: indexPath){
            return 16
        } else if !isNextMessageSameSender(at: indexPath) {
            return 16
        } else {
            return 0
        }
    }
}

// 상대방이 보낸 메시지, 내가 보낸 메시지를 구분하여 색상과 모양 지정
extension ChatViewController: MessagesDisplayDelegate {
    // 말풍선의 배경 색상
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .BaseGreen! : .BaseGray100!
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .BaseGray900!
    }
    
    // 말풍선의 꼬리 모양 방향
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        if isNextMessageSameSender(at: indexPath) && isNextMessageSameDate(at: indexPath) {
            return .bubble
        }
        
        let cornerDirection: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(cornerDirection, .pointedEdge)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in _: MessagesCollectionView) {
        let avatar = Avatar()
//        Avatar(image: <#T##UIImage?#>)
        avatarView.set(avatar: avatar)
        avatarView.isHidden = isNextMessageSameSender(at: indexPath) && isNextMessageSameDate(at: indexPath)
    }
    
    func configureAccessoryView(_ accessoryView: UIView, for _: MessageType, at indexPath: IndexPath, in _: MessagesCollectionView) {
//        if messages[indexPath.section].sender.senderId == "1" {
//            accessoryView.layer.cornerRadius = accessoryView.frame.height / 2
//            accessoryView.backgroundColor = .BaseGreen
//        }
        accessoryView.layer.cornerRadius = accessoryView.frame.height / 2
        accessoryView.backgroundColor = .BaseGreen
    }
}

extension ChatViewController: MessageCellDelegate {
    
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = Message(messageId: UUID().uuidString, sender: currentSender, sentDate: Date(), content: text)
        
        // TODO
//        saveMessageAndScrollToLastItem(message)
        
        insertNewMessage(message)
        inputBar.inputTextView.text.removeAll()
    }
}

extension UIViewController {
  func updateTitleView(title: String, subtitle: String?) {
    let titleLabel = UILabel(frame: CGRect(x: 0, y: -2, width: 0, height: 0))
    titleLabel.backgroundColor = UIColor.clear
    titleLabel.font = UIFont.systemFont(ofSize: 15)
    titleLabel.text = title
    titleLabel.textAlignment = .center
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.sizeToFit()

    let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: 0, height: 0))
    subtitleLabel.font = UIFont.systemFont(ofSize: 12)
    subtitleLabel.text = subtitle
    subtitleLabel.textAlignment = .center
    subtitleLabel.adjustsFontSizeToFitWidth = true
    subtitleLabel.sizeToFit()

    let titleView =
      UIView(frame: CGRect(x: 0, y: 0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 30))
    titleView.addSubview(titleLabel)
    if subtitle != nil {
      titleView.addSubview(subtitleLabel)
    } else {
      titleLabel.frame = titleView.frame
    }
    let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
    if widthDiff < 0 {
      let newX = widthDiff / 2
      subtitleLabel.frame.origin.x = abs(newX)
    } else {
      let newX = widthDiff / 2
      titleLabel.frame.origin.x = newX
    }

    navigationItem.titleView = titleView
  }
}
