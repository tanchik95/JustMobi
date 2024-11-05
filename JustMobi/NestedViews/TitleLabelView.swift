//
//  TitleLabel.swift
//  JustMobi
//
//  Created by Татьяна Исаева on 05.11.2024.
//

import UIKit
import SnapKit


final class TitleLabelView: UIView {

	// MARK: - Private properties

	private let titleLabel: UILabel = .init()

	// MARK: - Object lifecycle

	convenience init() {
		self.init(frame: .zero)
		setupUI()
		setupConstraints()
	}

	// MARK: - Setup UI

	private func setupUI() {
		addSubview(titleLabel)

		titleLabel.text = "Подходит для:"
		titleLabel.font = UIFont.systemFont(ofSize: 14)
		titleLabel.textColor = .white
	}

	// MARK: - Setup Constraints
	private func setupConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.top.bottom.leading.trailing.equalToSuperview()
		}
	}
}
