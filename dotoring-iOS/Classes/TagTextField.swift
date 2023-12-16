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
        textField.backgroundColor = .BaseGray100
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return textField
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .BaseGray700
        button.backgroundColor = .BaseGray100
//        button.isHidden = true
        
        return button
    }()
    
//    var isButtonVisible: Bool = false {
//        didSet {
//            button.isHidden = !isButtonVisible
//        }
//    }

    override init(frame: CGRect){
        super.init(frame: frame)
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
            $0.edges.equalToSuperview()
//            $0.width.greaterThanOrEqualTo(70)
        }
        
        
        button.snp.makeConstraints {
            $0.width.equalTo(12)
       }
       
//       button.isHidden = !isButtonVisible
    }
    
}
