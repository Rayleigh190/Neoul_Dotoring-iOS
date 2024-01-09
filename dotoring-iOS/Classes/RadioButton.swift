//
//  RadioButton.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/8/24.
//

import UIKit

protocol RadioButtonDelegate {
    func onClick(_ sender: UIView)
}

class RadioButton: UIButton {
    var checkedView: UIView?
    var uncheckedView: UIView?
    var delegate: RadioButtonDelegate?
    
    var isChecked: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    let label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 15)
        label.text = ""
        label.textColor = .BaseGray900
        return label
    }()
    
    init(text: String) {
        super.init(frame: .zero)
        label.text = text
        self.addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        checkedView?.removeFromSuperview()
        uncheckedView?.removeFromSuperview()
        label.removeFromSuperview()
        
        let view = isChecked ? checkedView : uncheckedView
        if let view = view {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.centerYAnchor.constraint(equalTo: centerYAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            ])
            
            addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.centerYAnchor.constraint(equalTo: centerYAnchor),
                label.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            ])
    
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: view.frame.height),
                self.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, constant: label.frame.width + 14),
            ])
        }
    }

    @objc func onClick(sender: UIButton) {
        if sender == self {
            delegate?.onClick(self)
        }
    }
}


class DefaultRadioButton: RadioButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        checkedView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        uncheckedView = UIImageView(image: UIImage(systemName: "circle"))
        checkedView?.tintColor = .BaseGray900
        uncheckedView?.tintColor = .BaseGray900
    }
    
    override init(text: String) {
        super.init(text: text)
        checkedView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        uncheckedView = UIImageView(image: UIImage(systemName: "circle"))
        checkedView?.tintColor = .BaseGray900
        uncheckedView?.tintColor = .BaseGray900
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
