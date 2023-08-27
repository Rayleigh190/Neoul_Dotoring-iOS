//
//  LineTextField.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/26.
//

import SnapKit
import UIKit

class LineTextField: UIView {
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()

    private lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
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
        [textField, line].forEach{ addSubview($0) }
        
        textField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        line.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom).offset(5.0)
            $0.height.equalTo(1.0)
        }
    }
    
}
