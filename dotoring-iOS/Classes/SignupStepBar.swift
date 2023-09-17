//
//  File.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/03.
//

import SnapKit
import UIKit

class SignupStepBar: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 7
        
        return stackView
    }()
    
    init(stepCount: Int, currentStep: Int) {
        super.init(frame: .zero)
        
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
                stepView.backgroundColor = UIColor.BaseGreen
            } else {
                stepView.backgroundColor = UIColor.BaseGray
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
