//
//  FieldRectView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/09.
//

import UIKit

class FieldRectView: UIView {
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var rectStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.borderWidth = 1
        
        if uiStyle == .mento {
            stackView.layer.borderColor = UIColor.BaseNavy?.cgColor
        } else {
            stackView.layer.borderColor = UIColor.BaseGreen?.cgColor
        }
        
        return stackView
    }()
    
    lazy var contentLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = "분야"
        
        if uiStyle == .mento {
            label.textColor = .BaseNavy
        } else {
            label.textColor = .BaseGreen
        }
        
        return label
    }()
    
    private lazy var leftEmptyView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var rightEmptyView: UIView = {
        let view = UIView()
        
        return view
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
    
    override func layoutSubviews() {
        super.layoutSubviews()

        rectStackView.layer.cornerRadius = rectStackView.frame.height/2
    }
    
    func setup() {
        setupSubViews()
//        updateUI()
    }
    
}

private extension FieldRectView {
    
    func setupSubViews() {
        
        [rectStackView].forEach {addSubview($0)}
        
        [leftEmptyView, contentLabel, rightEmptyView].forEach {rectStackView.addArrangedSubview($0)}
        
        rectStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.height.equalTo(47)
        }
        
        leftEmptyView.snp.makeConstraints {
            $0.width.equalTo(20)
        }
        
        rightEmptyView.snp.makeConstraints {
            $0.width.equalTo(20)
        }
        
    }
    
}
