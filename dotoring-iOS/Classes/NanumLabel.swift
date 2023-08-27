//
//  NanumLabel.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/26.
//

import UIKit

enum NanumWeightType {
    case L
    case R
    case B
    case EB
}

class NanumLabel: UILabel {
    
    init(weightType: NanumWeightType, size: CGFloat) {
        super.init(frame: .zero)
        
        var fontName = "NanumSquareOTF"
        
        switch weightType {
        case .L: fontName = fontName + "L"
        case .R: fontName = fontName + "R"
        case .B: fontName = fontName + "B"
        case .EB: fontName = fontName + "EB"
        }
        
        font = UIFont(name: fontName, size: size)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

private extension NanumLabel {
    func setupLabel() {
        
    }
}
