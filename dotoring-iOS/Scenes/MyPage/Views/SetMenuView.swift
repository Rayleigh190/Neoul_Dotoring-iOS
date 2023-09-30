//
//  SetMenuView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/30.
//

import UIKit

class SetMenuView: UIView {
    
    private lazy var menuLogoImage: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var chevronImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .black
        
        return imageView
    }()
    
    init(frame: CGRect, title: String, image:UIImage) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        menuLogoImage.image = image
        titleLabel.text = title.replacingOccurrences(of: " ", with: "\n")
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
//        updateUI()
        setupSubViews()
    }
    
}

private extension SetMenuView {
    
    func setupSubViews() {
        [menuLogoImage, titleLabel, chevronImage].forEach {addSubview($0)}
        
        menuLogoImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(21)
            $0.top.equalToSuperview().offset(21)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(menuLogoImage.snp.leading)
            $0.bottom.equalToSuperview().offset(-25)
        }
        
        chevronImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-21.5)
            $0.bottom.equalToSuperview().offset(-25)
        }
    }
    
}
