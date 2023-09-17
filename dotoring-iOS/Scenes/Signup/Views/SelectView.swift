//
//  SelectView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/05.
//

import UIKit

class SelectView: UIView {
    
    var elements: [String] = ["선택항목 1", "선택항목 2", "선택항목 3", "선택항목 4", "선택항목 5", "선택항목 6", "선택항목 7", "선택항목 8", "선택항목 9", "선택항목 10"]
    var selectedElements: [Int]?
    
    lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 20)
        label.textColor = .white
        label.text = "타이틀"
        
        return label
    }()
    
    private lazy var clearButton: BaseButton = {
        let button = BaseButton(style: .clear)
        button.setTitle("초기화", for: .normal)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 11)
//        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var selectedStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 5
        
        return stack
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .BaseGreen
        table.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        table.separatorColor = .white
        
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .BaseGreen
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
//        updateUI()
        setupSubViews()
    }


}

private extension SelectView {
    
    func updateUI() {
        for _ in 1...3 {
            let selectedElementView = SelectedElementView()
            selectedElementView.backgroundColor = .systemBackground
            selectedElementView.layer.cornerRadius = 36/2
            selectedElementView.snp.makeConstraints {
                $0.height.equalTo(36)
            }
            selectedStackView.addArrangedSubview(selectedElementView)
        }
        
    }
    
    func setupSubViews() {
        [titleLabel, clearButton, selectedStackView, tableView].forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalToSuperview().offset(29)
        }
        
        clearButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(38)
            $0.width.equalTo(53)
        }
        
        selectedStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.height.equalTo(5).priority(.low)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(selectedStackView.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
        }
    }
    
}

extension SelectView {
    @objc func selectedElementCancelButtonTapped(sender: UIButton!) {
        let cancelButtonTag = sender.tag
        print("일단 안 되서 넘어감")
//        let indexPathToDeselect = IndexPath(row: cancelButtonTag, section: 0)
//        tableView.deselectRow(at: indexPathToDeselect, animated: true)
    }
}

extension SelectView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        cell.backgroundColor = .BaseGreen
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = elements[indexPath.row]
        cell.selectionStyle = .none
        
        // 커스텀 뷰를 생성하고 accessoryView로 설정
        let customAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        customAccessoryView.layer.cornerRadius = 10
        customAccessoryView.layer.borderWidth = 1.5 // 테두리 추가
        customAccessoryView.layer.borderColor = UIColor.white.cgColor
        
        cell.accessoryView = customAccessoryView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let titleLabelText = tableView.cellForRow(at: indexPath)?.textLabel?.text,
           let indexToRemove = selectedStackView.arrangedSubviews
                .compactMap({ ($0 as? SelectedElementView)?.titleLabel.text })
                .firstIndex(of: titleLabelText) {
//            selectedStackView.removeArrangedSubview(selectedStackView.arrangedSubviews[indexToRemove])
            selectedStackView.arrangedSubviews[indexToRemove].removeFromSuperview()
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            // 선택 해제된 셀에서 커스텀 accessoryView를 다시 큰 원으로 변경
            let customAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            customAccessoryView.layer.cornerRadius = 10
            customAccessoryView.layer.borderWidth = 1.5
            customAccessoryView.layer.borderColor = UIColor.white.cgColor

            cell.accessoryView = customAccessoryView
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedElementView = SelectedElementView()
        selectedElementView.backgroundColor = .systemBackground
        selectedElementView.layer.cornerRadius = 36/2
        selectedElementView.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        selectedElements?.append(indexPath.row)
        selectedElementView.titleLabel.text = elements[indexPath.row]
        // Set a tag for the cancelButton
        selectedElementView.cancelButton.tag = indexPath.row
        selectedElementView.cancelButton.addTarget(self, action: #selector(selectedElementCancelButtonTapped), for: .touchUpInside)
        selectedStackView.addArrangedSubview(selectedElementView)
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let customAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20)) // 큰 원 추가
            customAccessoryView.layer.cornerRadius = 10
            customAccessoryView.layer.borderWidth = 1.5
            customAccessoryView.layer.borderColor = UIColor.white.cgColor
            customAccessoryView.backgroundColor = .clear
            
            // 선택된 셀에서 커스텀 accessoryView에 작은 원 추가
            let smallCustomAccessoryView = UIView(frame: CGRect(x: 3, y: 3, width: 14, height: 14)) // Autolayout을 적용하면 안 나타나서 x,y를 적용함
            smallCustomAccessoryView.backgroundColor = .systemBackground
            smallCustomAccessoryView.layer.cornerRadius = 7
            
            customAccessoryView.addSubview(smallCustomAccessoryView)

            cell.accessoryView = customAccessoryView
        }
    }


}
