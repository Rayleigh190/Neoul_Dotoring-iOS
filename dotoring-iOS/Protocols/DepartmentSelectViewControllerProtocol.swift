//
//  DepartmentSelectViewControllerProtocol.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/26.
//

import Foundation

protocol DepartmentSelectViewControllerDelegate: AnyObject {
    // 학과선택 뷰컨트롤러 화면이 사라질 때 선택한 학과 데이터를 받음
    func didDepartmentSelectViewControllerDismiss(elements: [String], selectedElements: [Int])
}
