//
//  ExpandableView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/25.
//

import UIKit

// search bar에서 사용할 확장 가능한 뷰
class ExpandableView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
}
