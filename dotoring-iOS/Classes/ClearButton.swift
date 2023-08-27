//
//  ClearButton.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/26.
//

import UIKit

class ClearButton: UIButton {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupButton()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupButton()
    }

}

private extension ClearButton {
    func setupButton() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 20.0
        backgroundColor = UIColor.clear
        setTitleColor(UIColor.black, for: .normal)
    }
}
