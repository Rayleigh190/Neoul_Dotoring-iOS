//
//  TagTextField.swift
//  dotoring-iOS
//
//  Created by 우진 on 12/15/23.
//

import UIKit
import SnapKit

class TagTextField: UIView {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.returnKeyType = .next
        
        return textField
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .BaseGray700
        
        return button
    }()

    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .BaseGray100
        self.layer.cornerRadius = 10
        self.snp.makeConstraints{$0.height.equalTo(40)}
        setupSubViews()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
}

private extension TagTextField {
    
    func setupSubViews() {
        [stackView].forEach{ addSubview($0) }
        
        [textField, button].forEach{ stackView.addArrangedSubview($0) }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(14)
            $0.top.bottom.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.width.equalTo(15)
       }

    }
    
}
