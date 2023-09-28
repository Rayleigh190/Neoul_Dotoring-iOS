//
//  SelectedElementView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/05.
//

import UIKit

class SelectedElementView: UIView {
    
    lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 15)
        label.textColor = .label
        label.text = "선택된 항목"
        
        return label
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
//        button.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        setupSubViews()
    }

}

private extension SelectedElementView {
    
    func setupSubViews() {
        [titleLabel, cancelButton].forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(23)
        }
        
        cancelButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(12.5)
        }
    }
    
}
