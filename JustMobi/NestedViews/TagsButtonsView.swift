//
//  TagsButtonsView.swift
//  JustMobi
//
//  Created by Татьяна Исаева on 05.11.2024.
//

import UIKit
import SnapKit


final class TagsButtonsView: UIView {

	// MARK: - Private properties

	private let scrollView: UIScrollView = .init()
	private let tagsStackView: UIStackView = .init()
	private let tags = ["#Осень", "#Портрет", "#Insta-стиль", "#Люди", "#Природа"]

	// MARK: - Object lifecycle

	convenience init() {
		self.init(frame: .zero)
		setupUI()
		setupConstraints()
	}

	// MARK: - Setup UI

	private func setupUI() {
		addSubview(scrollView)

		tagsStackView.axis = .horizontal
		tagsStackView.spacing = 6
		tagsStackView.alignment = .center
		scrollView.addSubview(tagsStackView)

		for tag in tags {
			let button = UIButton(type: .system)
			button.setTitle(tag, for: .normal)
			button.setTitleColor(UIColor(hex: "#00BFFF"), for: .normal)
			button.backgroundColor = UIColor.secondaryLabel
			button.layer.cornerRadius = 13
			button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
			button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
			tagsStackView.addArrangedSubview(button)
		}
	}

	// MARK: - Setup Constraints
	private func setupConstraints() {
		scrollView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(16) 
			make.leading.trailing.equalToSuperview()
			make.height.equalTo(50)
		}

		tagsStackView.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview()
			make.leading.trailing.equalToSuperview()
		}
	}
}
