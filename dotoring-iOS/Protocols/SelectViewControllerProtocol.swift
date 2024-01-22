//
//  JobSelectViewControllerProtocol.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/26.
//

import UIKit

protocol SelectViewControllerDelegate: AnyObject {
    // SelectViewController 화면이 사라질 때 선택항목 데이터를 받습니다.
    func didSelectViewControllerDismiss(elements: [String], selectedElements: [Int], sender: UIButton)
}
