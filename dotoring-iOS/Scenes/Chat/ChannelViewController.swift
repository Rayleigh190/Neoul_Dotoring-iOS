//
//  ChannelViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/25/23.
//

import UIKit
import MessageKit

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}

class ChannelViewController: UIViewController {
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 34)
        label.text = "채팅방"
        label.textColor = .BaseGray900
        
        return label
    }()

    lazy var channelTableView: UITableView = {
        let view = UITableView()
        view.register(ChannelTableViewCell.self, forCellReuseIdentifier: ChannelTableViewCell.className)
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    
    var channels = [
        Channel(id: "0", name: "홍길동", major: "경영학과", lastLetter: "우리 언제 만나요?", updateAt: "6월 19일 14시 55분"),
        Channel(id: "1", name: "김이식", major: "컴퓨터공학과", lastLetter: "개발이 너무 어려워요ㅠㅠ", updateAt: "6월 18일 10시 25분")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        
        [titleLabel, channelTableView].forEach{view.addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(59)
        }
        
        channelTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(45)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
}

extension ChannelViewController: UITableViewDataSource, UITableViewDelegate {
    // 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    // 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChannelTableViewCell.className, for: indexPath) as! ChannelTableViewCell
        
        if channels.count > 0 {
            let channel = channels[indexPath.row]
            cell.chatRoomNicknameLabel.text = channel.name
            cell.chatRoomDepartmentLabel.text = channel.major
            cell.chatRoomContentLabel.text = channel.lastLetter
            cell.chatRoomDateLabel.text = channel.updateAt
        }
        return cell
    }
    
    // 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    // 셀 선택 됐을때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        channelTableView.deselectRow(at: indexPath, animated: true)
        let channel = channels[indexPath.row]
        let vc = ChatViewController(channel: channel)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
