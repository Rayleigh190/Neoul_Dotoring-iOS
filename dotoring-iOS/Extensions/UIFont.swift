//
//  UIFont.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/27.
//

import UIKit

enum NanumFamily {
    case NanumSquareOTFL
    case NanumSquareOTFR
    case NanumSquareOTFB
    case NanumSquareOTFEB
}

extension UIFont {
    
    static func nanumSquare(style: NanumFamily, size: CGFloat) -> UIFont {
        return UIFont(name: "\(style)", size: size)!
    }
    
}
