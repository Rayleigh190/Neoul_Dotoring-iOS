//
//  LineTextField.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/26.
//

import SnapKit
import UIKit

class LineTextField: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return textField
    }()
    
    lazy var button: UIButton = {
        let button = BaseButton(style: .clear)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 10)
        
        return button
    }()

    private lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = .BaseGray900
        
        return view
    }()
    
    var isButtonVisible: Bool = false {
        didSet {
            button.isHidden = !isButtonVisible
        }
    }

    override init(frame: CGRect){
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
}

private extension LineTextField {
    
    func setupSubViews() {
        [stackView, line].forEach{ addSubview($0) }
        
        [textField, button].forEach{ stackView.addArrangedSubview($0) }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        line.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom).offset(5.0)
            $0.height.equalTo(1.0)
        }
        
        button.snp.makeConstraints {
            $0.width.equalTo(76)
       }
       
       button.isHidden = !isButtonVisible
    }
    
}
