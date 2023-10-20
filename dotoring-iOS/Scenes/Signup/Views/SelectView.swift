//
//  SelectView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/05.
//

import UIKit

class SelectView: UIView {
    
    var uiColor: UIColor = UIColor.BaseGray!
    var elements: [String] = ["선택항목 1", "선택항목 2", "선택항목 3", "선택항목 4", "선택항목 5", "선택항목 6", "선택항목 7", "선택항목 8", "선택항목 9", "선택항목 10"]
    var selectedElements: [Int] = [] // 선택한 항목 cell의 indexPath를 저장
    
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
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
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
        table.backgroundColor = uiColor
        table.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        table.separatorColor = .white
        
        return table
    }()
    
    init(frame: CGRect, title: String, style:UIStyle) {
        super.init(frame: frame)
        
        switch style {
        case .mento:
            backgroundColor = .BaseGreen
            uiColor = .BaseGreen!
        case .mentee:
            backgroundColor = .BaseNavy
            uiColor = .BaseNavy!
            clearButton.layer.borderColor = UIColor(red: 0.349, green: 0.475, blue: 0.62, alpha: 1).cgColor
            clearButton.setTitleColor(UIColor(red: 0.349, green: 0.475, blue: 0.62, alpha: 1), for: .normal)
        }
        
        titleLabel.text = title
        
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
    
    /**
     * selectedElement(선택된 요소)의 cancel button이 눌렸을때 tableView의 cell을 deselect함.
     */
    @objc func selectedElementCancelButtonTapped(sender: UIButton!) {
        tableView(tableView, didDeselectRowAt: IndexPath(row: sender.tag, section: 0))
        tableView.deselectRow(at: IndexPath(row: sender.tag, section: 0), animated: true)
    }
    
    /**
     * 모든 선택된 요소에 대해 deselect을 수행함.
     */
    @objc func clearButtonTapped(sender: UIButton!) {
        for i in selectedElements {
            tableView.deselectRow(at: IndexPath(row: i, section: 0), animated: true)
            tableView(tableView, didDeselectRowAt: IndexPath(row: i, section: 0))
        }
    }
}

extension SelectView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        cell.backgroundColor = uiColor
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
        print("Deselect: \(indexPath.row), section: \(indexPath.section)")
        // selectedElements에서 해당 indexPath 제거
        // firstIndex가 없을 수도 있나?
        if let selectedElementIndex = selectedElements.firstIndex(of: indexPath.row) {
            selectedElements.remove(at: selectedElementIndex)
        } else { return }
        
        if let indexToRemove = selectedStackView.arrangedSubviews.compactMap({ ($0 as? SelectedElementView)?.tag }).firstIndex(of: indexPath.row) {
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
        print("select: \(indexPath.row), section: \(indexPath.section)")
        let selectedElementView = SelectedElementView()
        selectedElementView.backgroundColor = .systemBackground
        selectedElementView.layer.cornerRadius = 36/2
        selectedElementView.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        selectedElements.append(indexPath.row)
        selectedElementView.titleLabel.text = elements[indexPath.row]
        // Set a tag for the cancelButton
        selectedElementView.tag = indexPath.row
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
    
    /**
     * cell이 보여지기 전에 선택 되어 있는 cell인지 확인해서 customAccessoryView를 설정함.
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.isSelected {
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
