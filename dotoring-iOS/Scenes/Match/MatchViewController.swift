//
//  MatchViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/1/24.
//

import UIKit
import SnapKit

class MatchViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0

        let bannerSectionView = BannerSectionView(frame: .zero)
        let searchSectionView = SearchSectionView(frame: .zero)

        let spacingView = UIView()
        spacingView.backgroundColor = .systemBackground
        spacingView.snp.makeConstraints {
            $0.height.equalTo(50.0)
        }

        [
            bannerSectionView,
            searchSectionView,
            spacingView
        ].forEach {
            stackView.addArrangedSubview($0)
        }

        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        setupNavigationController()
        setupLayout()
    }

}

private extension MatchViewController {
    func setupNavigationController() {
        navigationItem.title = "매칭"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
