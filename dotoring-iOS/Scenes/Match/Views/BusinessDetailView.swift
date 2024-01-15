//
//  BusinessDetailView.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/14/24.
//

import UIKit

class BusinessDetailView: UIView {
    var isAuthor: Bool = false
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        if uiStyle == .mento {
            imageView.image = UIImage(named: "MenteeProfileBaseImg")
        } else {
            imageView.image = UIImage(named: "MentoProfileBaseImg")
        }
        return imageView
    }()
    
    private lazy var nicknameLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 13)
        label.text = "닉네임"
        if uiStyle == .mento {
            label.textColor = .BaseGreen
        } else {
            label.textColor = .BaseNavy
        }
        return label
    }()
    
    private lazy var departmentLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 13)
        label.text = "· 학과"
        label.textColor = .BaseGray700
        return label
    }()
    
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 6
        stackView.alignment = .center
        [profileImage, nicknameLabel, departmentLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var pjtGoalView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 5
        let label = NanumLabel(weightType: .B, size: 13)
        label.text = "프로젝트목표"
        view.addSubview(label)
        view.snp.makeConstraints {
            $0.width.equalTo(92)
            $0.height.equalTo(29)
        }
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        return view
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        let spaceView = UIView()
        [profileStackView, spaceView, pjtGoalView].forEach {stackView.addArrangedSubview($0)}
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var pjtTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .BaseGray200
        textView.textColor = .BaseGray900
        textView.isEditable = true
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 16)
        textView.layer.cornerRadius = 20
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 17, left: 13, bottom: 17, right: 13)
        return textView
    }()
    
    private lazy var pjtStackView: UIStackView = {
        let stackView = createContentSection(text: "프로젝트 설명", textView: pjtTextView, label: nil)
        return stackView
    }()
    
    private lazy var teamTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .BaseGray200
        textView.textColor = .BaseGray900
        textView.isEditable = true
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 16)
        textView.layer.cornerRadius = 20
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 17, left: 13, bottom: 17, right: 13)
        return textView
    }()
    
    private lazy var teamStackView: UIStackView = {
        let stackView = createContentSection(text: "모집 팀원", textView: teamTextView, label: nil)
        return stackView
    }()
    
    private lazy var methodTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .BaseGray200
        textView.textColor = .BaseGray900
        textView.isEditable = true
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 16)
        textView.layer.cornerRadius = 20
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 17, left: 13, bottom: 17, right: 13)
        return textView
    }()
    
    private lazy var methodStackView: UIStackView = {
        let stackView = createContentSection(text: "진행 방식", textView: methodTextView, label: nil)
        return stackView
    }()
    
    lazy var personnelLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 15)
        label.text = "2/7"
        return label
    }()
    
    private lazy var personnelStackView: UIStackView = {
        let stackView = createContentSection(text: "필요 인원", textView: nil, label: personnelLabel)
        return stackView
    }()
    
    private lazy var middleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .systemBackground
        stackView.spacing = 30
        stackView.layer.cornerRadius = 20
        stackView.layer.maskedCorners = [.layerMinXMinYCorner]
        stackView.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        stackView.layer.shadowOpacity = 1
        stackView.layer.shadowOffset = CGSize(width: 0, height: 0)
        stackView.layer.shadowRadius = 5
        
        let spaceView = UIView()
        spaceView.snp.makeConstraints {$0.height.equalTo(10)}
        let spaceView2 = UIView()
        spaceView2.snp.makeConstraints {$0.height.equalTo(200)}
        spaceView2.backgroundColor = .systemBackground
        
        [spaceView, pjtStackView, teamStackView, methodStackView, personnelStackView, spaceView2].forEach {stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private lazy var backgroundStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        
        let spaceView1 = UIView()
        spaceView1.snp.makeConstraints {$0.height.equalTo(20)}
        
        
        [spaceView1, headerStackView, middleStackView].forEach {stackView.addArrangedSubview($0)}
        return stackView
    }()
    
    lazy var joinButton: BaseButton = {
        let button = BaseButton(style: .green)
        if uiStyle == .mentee {
            button.setupButton(style: .navy)}
        button.setTitle("참여할래요!", for: .normal)
        button.snp.makeConstraints { $0.height.equalTo(45) }
        return button
    }()
    
    lazy var editButton: BaseButton = {
        let button = BaseButton(style: .green)
        button.setTitle("수정", for: .normal)
        if uiStyle == .mentee {
            button.setupButton(style: .navy)}
//        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.snp.makeConstraints { $0.height.equalTo(45) }
        return button
    }()
    
    lazy var endButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("마감", for: .normal)
        button.backgroundColor = .BaseGray600
        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.snp.makeConstraints { $0.height.equalTo(45) }
        return button
    }()
    
    private lazy var footerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemBackground
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        if isAuthor {
            [editButton, endButton].forEach {stackView.addArrangedSubview($0)}
        } else {
            [joinButton].forEach {stackView.addArrangedSubview($0)}
        }
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 30, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    func setup() {
        setupSubViews()
    }
    
}

private extension BusinessDetailView {
    func createContentSection(text: String, textView: UITextView?, label: NanumLabel?) -> UIStackView {
        let subStackView = UIStackView()
        subStackView.axis = .horizontal
        subStackView.spacing = 6
        subStackView.alignment = .center
        
        let titleLabel = NanumLabel(weightType: .B, size: 17)
        titleLabel.text = text
        titleLabel.textColor = .BaseGray700
        
        let acc = createLeftAcc()
        [acc, titleLabel].forEach {
            subStackView.addArrangedSubview($0)
        }
        
        let textStackView = UIStackView()
        textStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        textStackView.isLayoutMarginsRelativeArrangement = true
        
        if textView == nil {
            let spaceView = UIView()
            spaceView.snp.makeConstraints {$0.width.equalTo(20)}
            if let unwrapLabel = label {
                [spaceView, unwrapLabel].forEach {
                    textStackView.addArrangedSubview($0)}
            }
        } else {
            if let unwrapTextView = textView {
                textStackView.addArrangedSubview(unwrapTextView)
            }
        }
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12

        [subStackView, textStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }
    
    func createLeftAcc() -> UIView {
        let view = UIView()
        if uiStyle == .mento {
            view.backgroundColor = .BaseGreen
        } else {
            view.backgroundColor = .BaseNavy
        }
        view.snp.makeConstraints {
            $0.width.equalTo(29)
            $0.height.equalTo(11)
        }
        return view
    }
    
    func updateUI() {
    }
    
    func setupSubViews() {
        
        addSubview(scrollView)
        addSubview(footerStackView)
        scrollView.addSubview(backgroundStackView)

        scrollView.snp.makeConstraints {
           $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        backgroundStackView.snp.makeConstraints {
           $0.edges.width.equalToSuperview()
        }
        
        footerStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
