//
//  File.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/03.
//

import SnapKit
import UIKit

class SignupStepBar: UIView {
    
    var uiColor: UIColor = .BaseGray100!
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 7
        
        return stackView
    }()
    
    init(stepCount: Int, currentStep: Int, style: UIStyle) {
        super.init(frame: .zero)
        
        switch style {
        case .mento: uiColor = UIColor.BaseGreen!
        case .mentee: uiColor = UIColor.BaseNavy!
        }
        
        setupStackView(stepCount: stepCount, currentStep: currentStep)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView(stepCount: Int, currentStep: Int) {
        for i in 0..<stepCount {
            let stepView = UIView()
            if i < currentStep {
                stepView.backgroundColor = uiColor
            } else {
                stepView.backgroundColor = UIColor.BaseGray100
            }
            
            stepView.snp.makeConstraints { make in
                make.width.equalTo(20)
                make.height.equalTo(20)
            }
            
            stepView.layer.cornerRadius = 10
            
            stackView.addArrangedSubview(stepView)
        }
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
