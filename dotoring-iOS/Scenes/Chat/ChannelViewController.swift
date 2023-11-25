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
        
    var channels = [Channel]()
    
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
        
        channels = getChannelMocks()
    }
    
}

extension ChannelViewController: UITableViewDataSource, UITableViewDelegate {
    // 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
//        return 5
    }
    
    // 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChannelTableViewCell.className, for: indexPath) as! ChannelTableViewCell
        
        if channels.count > 0 {
            cell.chatRoomNicknameLabel.text = channels[indexPath.row].name
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
