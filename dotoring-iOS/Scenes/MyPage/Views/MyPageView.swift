//
//  MyPageView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/30.
//

import UIKit

/**
 * 마이페이지 View입니다.
 */
final class MyPageView: UIView {
    
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
    
    // 마이페이지 상단에 사용자 닉네임과 프로필 이미지를 보여주는 View입니다.
    private lazy var profileCardView: ProfileCardView = {
        let view = ProfileCardView(frame: frame)
        view.layer.cornerRadius = 20
        
        if uiStyle == .mento {
            view.backgroundColor = .BaseGreen
        } else {
            view.backgroundColor = .BaseNavy
        }
        
        return view
    }()
    
    private lazy var schoolLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 15)
        label.textColor = .BaseGray600
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.text = "학교 |"
        
        return label
    }()
    
    lazy var schoolTextField: UITextField = {
        let textField = UITextField()
        textField.text = "기존 학교"
        textField.isEnabled = false
        textField.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 20)
        return textField
    }()
    
    private lazy var schoolStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        [schoolLabel, schoolTextField].forEach {stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private lazy var dashedLine1ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DashedLineImg")
        
        return imageView
    }()
    
    private lazy var fieldLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 15)
        label.textColor = .BaseGray600
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.text = "분야 |"
        
        return label
    }()
    
    lazy var fieldTextField: UITextField = {
        let textField = UITextField()
        textField.text = "멘토링 분야"
        textField.isEnabled = false
        textField.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 20)
        return textField
    }()
    
    lazy var fieldButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var fieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        [fieldLabel, fieldTextField].forEach {stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private lazy var dashedLine2ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DashedLineImg")
        
        return imageView
    }()
    
    private lazy var gradeLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 15)
        label.textColor = .BaseGray600
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.text = "학년 |"
        
        return label
    }()
    
    lazy var gradeTextField: UITextField = {
        let textField = UITextField()
        textField.text = "0"
        textField.isEnabled = false
        textField.keyboardType = .numberPad
        textField.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 20)
        return textField
    }()
    
    private lazy var gradeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        [gradeLabel, gradeTextField].forEach {stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private lazy var dashedLine3ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DashedLineImg")
        
        return imageView
    }()
    
    private lazy var departmentLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 15)
        label.textColor = .BaseGray600
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.text = "학과 |"
        
        return label
    }()
    
    lazy var departmentTextField: UITextField = {
        let textField = UITextField()
        textField.text = "X학과"
        textField.isEnabled = false
        textField.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 20)
        return textField
    }()
    
    lazy var departmentButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var departmentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        [departmentLabel, departmentTextField].forEach {stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private lazy var dashedLine4ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DashedLineImg")
        
        return imageView
    }()
    
    private lazy var tagLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 15)
        label.textColor = .BaseGray600
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.text = "태그"
        
        return label
    }()
    
    lazy var tagSubLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
        label.textColor = .BaseGray700
        label.text = "#제외 6자 이하, 태그 3개 이하 작성, #은 자동으로 채워집니다."
        label.isHidden = true
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var tagTextField1: TagTextField = {
        let textField = TagTextField(isEnabled: false)
        textField.textField.text = "#태그1"
        textField.button.tag = 1
        return textField
    }()
    
    lazy var tagTextField2: TagTextField = {
        let textField = TagTextField(isEnabled: false)
        textField.textField.text = "#태그2"
        textField.button.tag = 2
        return textField
    }()
    
    lazy var tagTextField3: TagTextField = {
        let textField = TagTextField(isEnabled: false)
        textField.textField.text = "#태그3"
        textField.button.tag = 3
        return textField
    }()
    
    private lazy var tagLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.alignment = .bottom
        [tagLabel, tagSubLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var tagStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        
        let subStackView = UIStackView()
        subStackView.spacing = 5
        subStackView.axis = .vertical
        [tagTextField1, tagTextField2, tagTextField3].forEach {
            subStackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.greaterThanOrEqualTo(80)
            }
        }
        
        [tagLabelStackView, subStackView].forEach {stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private lazy var dashedLine5ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DashedLineImg")
        
        return imageView
    }()
    
    private lazy var methodLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 15)
        label.textColor = .BaseGray600
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.text = "멘토링 방식"
        
        return label
    }()
    
    private lazy var methodTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.textColor = .BaseGray900
        textView.isEditable = false
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 16)
        textView.layer.cornerRadius = 10
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 13, left: 14, bottom: 13, right: 14)
        textView.text = "기존 내용"
        return textView
    }()
    
    private lazy var methodStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        
        [methodLabel, methodTextView].forEach {stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        
        [schoolStackView, dashedLine1ImageView,
         fieldStackView, dashedLine2ImageView,
         gradeStackView, dashedLine3ImageView,
         departmentStackView, dashedLine4ImageView,
         tagStackView, dashedLine5ImageView,
         methodStackView].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그아웃", for: .normal)
        button.tintColor = .systemBackground
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        let spaceView0 = UIView()
        
        let spaceView = UIView()
        spaceView.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        let spaceView2 = UIView()
        spaceView2.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        [spaceView0,profileCardView, userInfoStackView, spaceView, logoutButton, spaceView2].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    lazy var cancelButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("수정 취소", for: .normal)
        return button
    }()
    
    lazy var doneButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("완료", for: .normal)
        button.isEnabled = false
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.isHidden = true
        [cancelButton, doneButton].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    let editSpaceView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    init(isEditable: Bool = true) {
        super.init(frame: .zero)
        setup()
        setupEditable()
        backgroundColor = .systemBackground
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .BaseGray100
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(buttonStackView.frame.width * 0.28)
        }
        
        editSpaceView.snp.makeConstraints {
            $0.height.equalTo(buttonStackView.frame.height)
        }
        mainStackView.addArrangedSubview(editSpaceView)
    }
    
    func setup() {
        setupSubViews()
    }
    
}

private extension MyPageView {
    
    func setupSubViews() {
        [scrollView, buttonStackView, fieldButton, departmentButton].forEach {
            addSubview($0)
        }
        scrollView.addSubview(mainStackView)

        scrollView.snp.makeConstraints {
           $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        mainStackView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }

        profileCardView.snp.makeConstraints {
            $0.height.equalTo(profileCardView.frame.width * 0.34)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(17)
        }
        
        fieldButton.snp.makeConstraints {
            $0.edges.equalTo(fieldTextField)
        }
        
        departmentButton.snp.makeConstraints {
            $0.edges.equalTo(departmentTextField)
        }
    }
    
    func setupEditable() {
        profileCardView.isHidden = true
        logoutButton.isHidden = true
        methodStackView.isHidden = true
        dashedLine5ImageView.isHidden = true
        gradeTextField.isEnabled = true
        schoolTextField.isEnabled = true
        [tagTextField1, tagTextField2, tagTextField3].forEach {
            $0.setEnabled()
        }
        buttonStackView.isHidden = false
        editSpaceView.isHidden = false
        tagSubLabel.isHidden = false
    }
}
