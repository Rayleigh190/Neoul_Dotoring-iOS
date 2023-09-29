//
//  JobSelectViewControllerProtocol.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/26.
//

import UIKit

protocol SelectViewControllerDelegate: AnyObject {
    // 직무선택 뷰컨트롤러 화면이 사라질 때 선택한 직무 데이터를 받음
    func didSelectViewControllerDismiss(elements: [String], selectedElements: [Int], sender: UIButton)
}
