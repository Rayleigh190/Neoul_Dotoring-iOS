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
        removeConstraints(self.constraints)
        
        let view = isChecked == true ? checkedView : uncheckedView
        if let view = view {
            addSubview(view)
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.centerYAnchor.constraint(equalTo: centerYAnchor)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
