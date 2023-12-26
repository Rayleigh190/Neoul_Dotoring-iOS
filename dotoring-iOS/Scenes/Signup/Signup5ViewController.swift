//
//  MentoSignup5ViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/24.
//

import UIKit

class Signup5ViewController: UIViewController {
    // Signup Data
    var school: String = ""
    var grade: Int = 0
    var fields: [String] = []
    var majors: [String] = []
    var certificationsFileURL: URL?
    var nickname: String = ""
    var introduction: String = ""

    var signup5View: Signup5View!
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.title = ""
        self.hideKeyboardWhenTappedAround()
        setupNavigationBar()
    }
    
    override func loadView() {
        super.loadView()
        
        signup5View = Signup5View(frame: self.view.frame)
        
        signup5View.nextButtonActionHandler = { [weak self] in
            self?.nextButtonTapped()
        }
        
        self.view = signup5View
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.setAnimationsEnabled(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(false)
    }
    
    func nextButtonTapped() {
        if !signup5View.agreeConfirmButton.isSelected {
            self.view.makeToast("동의 체크버튼을 눌러주세요.", position: .top)
            return
        }
        
        let vc = Signup6ViewController()
        vc.school = school
        vc.grade = grade
        vc.fields = fields
        vc.majors = majors
        vc.certificationsFileURL = certificationsFileURL
        vc.nickname = nickname
        vc.introduction = "안녕하세요 전남대학교 4학년 최우진입니다."
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.tintColor = .BaseGray700
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let titleLabel = UILabel()
        var attrRangeText = ""
        var attrStrColor = UIColor.label

        titleLabel.textColor = UIColor.label // 전체 글씨 색상
        titleLabel.font = .nanumSquare(style: .NanumSquareOTFR, size: 15)
        titleLabel.sizeToFit()

        if uiStyle == .mentee {
            titleLabel.text = "멘티로 회원가입"
            attrRangeText = "멘티"
            attrStrColor = .BaseNavy!
        } else {
            titleLabel.text = "멘토로 회원가입"
            attrRangeText = "멘토"
            attrStrColor = .BaseGreen!
        }
        
        let attributedString = NSMutableAttributedString(string: titleLabel.text!)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: attrStrColor, range: (titleLabel.text! as NSString).range(of: attrRangeText))

        titleLabel.attributedText = attributedString

        self.navigationItem.titleView = titleLabel
    }
    
}
