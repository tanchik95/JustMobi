//
//  PhotoAlbumCustomView.swift
//  JustMobi
//
//  Created by Татьяна Исаева on 05.11.2024.
//

import UIKit
import SnapKit

final class PhotoAlbumCustomView: UIView {

	// MARK: - Private properties

	private let bunnerView: PremiumBannerView = .init()
	private let titleLabel: TitleLabelView = .init()
	private let tagsButtonsView: TagsButtonsView = .init()
	private let collectionView: MosaicLayoutCollectionView = .init()
	private let animationGiftView: AnimationGiftView = .init()

	// MARK: - Init

	convenience init() {
		self.init(frame: .zero)
		setup()
	}

	// MARK: - Setup (private)

	private func setup() {
		addSubview(bunnerView)
		addSubview(tagsButtonsView)
		addSubview(titleLabel)
		addSubview(collectionView)
		addSubview(animationGiftView)

		setupConstraints()
	}

	private func setupConstraints() {
		bunnerView.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
			make.leading.trailing.equalToSuperview()
		}

		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(bunnerView.snp.bottom).offset(16)
			make.leading.trailing.equalToSuperview()
		}

		tagsButtonsView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom)
			make.leading.trailing.equalToSuperview()
			make.height.equalTo(50)
		}

		collectionView.snp.makeConstraints { make in
			make.top.equalTo(tagsButtonsView.snp.bottom).offset(16)
			make.bottom.leading.trailing.equalToSuperview()
		}

		animationGiftView.snp.makeConstraints { make in
			make.width.height.equalTo(150)
			make.bottom.equalToSuperview().offset(-32)
			make.right.equalToSuperview().offset(-16)
		}
	}
}
