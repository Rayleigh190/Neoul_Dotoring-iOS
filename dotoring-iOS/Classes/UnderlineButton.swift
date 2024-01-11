//
//  UnderlineButton.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/4/24.
//

import UIKit

class UnderlineButton: UIView {
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 3
        return stackView
    }()
    
    let label = NanumLabel(weightType: .R, size: 15)
    
    let underline: UIView = {
        let view = UIView()
        view.backgroundColor = .BaseGray600
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    init(text: String, style: UnderlineButtonStyle){
        super.init(frame: .zero)
        label.text = text
        switch style {
        case .green: setupButton(style: .green)
        case .navy: setupButton(style: .navy)
        case .gray: setupButton(style: .gray)
        }
        setupSubViews()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

extension UnderlineButton {
    func setupButton(style: UnderlineButtonStyle) {
        
        switch style {
        case .gray:
            label.textColor = .BaseGray600
            underline.backgroundColor = .BaseGray600
        case .navy:
            label.textColor = .BaseNavy
            underline.backgroundColor = .BaseNavy
        case .green:
            label.textColor = .BaseGreen
            underline.backgroundColor = .BaseGreen
        }
        
    }
}

private extension UnderlineButton {
    
    func setupSubViews() {
        [stackView, button].forEach{ addSubview($0) }
        
        [label, underline].forEach{ stackView.addArrangedSubview($0) }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        underline.snp.makeConstraints {
            $0.width.equalTo(stackView)
            $0.height.equalTo(3)
        }
        
        button.snp.makeConstraints {
            $0.edges.equalTo(stackView)
        }

    }
    
    @objc func buttonTapped(sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            if uiStyle == .mento {
                setupButton(style: .green)
            } else {
                setupButton(style: .navy)
            }
        } else {
            setupButton(style: .gray)
        }
    }
    
}
