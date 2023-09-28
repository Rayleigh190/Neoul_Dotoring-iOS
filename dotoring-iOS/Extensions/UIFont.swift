//
//  UIFont.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/27.
//

import UIKit

extension UIFont {
    
    static func nanumSquare(style: NanumFamily, size: CGFloat) -> UIFont {
        return UIFont(name: "\(style)", size: size)!
    }
    
}
