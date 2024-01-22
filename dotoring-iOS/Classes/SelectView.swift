//
//  SelectView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/05.
//

import UIKit

class SelectView: UIView {
    var uiColor: UIColor = UIColor.BaseGray200!
    var elements: [String] = ["선택항목 1", "선택항목 2", "선택항목 3", "선택항목 4", "선택항목 5", "선택항목 6", "선택항목 7", "선택항목 8", "선택항목 9", "선택항목 10"]
    var selectedElements: [Int] = [] // 선택한 항목 cell의 indexPath를 저장
    var previousSelectedElements: [Int]
    
    private lazy var titleLabel: NanumLabel = {
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
    
    lazy var selectedStackView: UIStackView = {
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
        table.allowsMultipleSelection = true
        
        return table
    }()
    
    init(frame: CGRect, titleText: String, style:UIStyle, elements: [String], previousSelectedElements: [Int]) {
        self.elements = elements
        self.previousSelectedElements = previousSelectedElements
        super.init(frame: frame)
        titleLabel.text = titleText
        
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
        setup()
        setPreviousSelectedElement()    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        setupSubViews()
    }


}

private extension SelectView {
    
    func setupSubViews() {
        [titleLabel, clearButton, selectedStackView, tableView].forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(17)
            $0.top.equalToSuperview().offset(29)
        }
        
        clearButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(53)
        }
        
        selectedStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(17)
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
    
    /**
     * tableView의 cell을 선택 할 수 있는 함수입니다.
     */
    func elementSelect(selectedElementIndex: IndexPath) {
        tableView.selectRow(at: selectedElementIndex, animated: true, scrollPosition: .none)
        tableView(tableView, didSelectRowAt: selectedElementIndex)
    }
    
    func setPreviousSelectedElement() {
        // 선택후 닫았다 다시 열었을때 이전에 선택 했던 것들 다시 선택
        if previousSelectedElements.count < 1 {return}
        for previousSelectedElement in self.previousSelectedElements {
            let indexPath = IndexPath(row: previousSelectedElement, section: 0)
            elementSelect(selectedElementIndex: indexPath)
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
        let customAccessoryView = createCircleAccView(isSelected: false)
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
           let customAccessoryView = createCircleAccView(isSelected: false)
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
            let customAccessoryView = createCircleAccView(isSelected: true)
            cell.accessoryView = customAccessoryView
        }
    }
    
    /**
     * cell이 보여지기 전에 선택 되어 있는 cell인지 확인해서 customAccessoryView를 설정함.
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.isSelected {
            let customAccessoryView = createCircleAccView(isSelected: true)
            cell.accessoryView = customAccessoryView
        }
    }

    func createCircleAccView(isSelected: Bool) -> UIView {
        let largeCircleView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        largeCircleView.layer.cornerRadius = 10
        largeCircleView.layer.borderWidth = 1.5
        largeCircleView.layer.borderColor = UIColor.systemBackground.cgColor
        largeCircleView.backgroundColor = .clear
        if isSelected {
            let smallCircleView = UIView(frame: CGRect(x: 3, y: 3, width: 14, height: 14))
            smallCircleView.backgroundColor = .systemBackground
            smallCircleView.layer.cornerRadius = 7
            largeCircleView.addSubview(smallCircleView)
        }
        return largeCircleView
    }
}
