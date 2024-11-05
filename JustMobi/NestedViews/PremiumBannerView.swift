//
//  Extension + UIColor.swift
//  JustMobi
//
//  Created by Татьяна Исаева on 30.10.2024.
//

import UIKit
import SnapKit

final class PremiumBannerView: UIView {

	// MARK: - Private properties
	private let titleLabel = UILabel()
	private let subtitleLabel = UILabel()
	private let imagesStackView = UIStackView()

	// MARK: - Object lifecycle
	
	convenience init() {
		self.init(frame: .zero)
		setupView()
	}

	private func setupView() {
		layer.cornerRadius = 16
		clipsToBounds = true

		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [
			UIColor(hex: "8B67EF").cgColor,
			UIColor(hex: "C373E7").cgColor
		]

		gradientLayer.locations = [0.5, 1.0]
		gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
		gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)

		layer.insertSublayer(gradientLayer, at: 0)

		titleLabel.text = "Try three days free trial"
		titleLabel.textColor = .white
		titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
		addSubview(titleLabel)

		subtitleLabel.text = "You will get all premium templates,\nadditional stickers and no ads"
		subtitleLabel.textColor = .white.withAlphaComponent(0.8)
		subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
		subtitleLabel.numberOfLines = 0
		addSubview(subtitleLabel)

		setupImagesStack()
		setupConstraints()
	}

	private func setupImagesStack() {
		imagesStackView.axis = .horizontal
		imagesStackView.spacing = 6
		addSubview(imagesStackView)

		let leftStack = UIStackView()
		leftStack.axis = .vertical
		leftStack.spacing = 6
		leftStack.distribution = .fill

		let rightStack = UIStackView()
		rightStack.axis = .vertical
		rightStack.spacing = 6
		rightStack.distribution = .fill

		let images = [
			UIImage(named: "womenImage"),
			UIImage(named: "sunsetImage"),
			UIImage(named: "flowerImage"),
			UIImage(named: "seaImage")
		]

		leftStack.addArrangedSubview(createImageView(with: images[0], width: 46, height: 51, cornerRadius: 3))
		rightStack.addArrangedSubview(createImageView(with: images[1], width: 46, height: 23, cornerRadius: 3))
		rightStack.addArrangedSubview(createImageView(with: images[2], width: 46, height: 51, cornerRadius: 3))
		leftStack.addArrangedSubview(createImageView(with: images[3], width: 46, height: 23, cornerRadius: 3))

		imagesStackView.addArrangedSubview(leftStack)
		imagesStackView.addArrangedSubview(rightStack)
	}

	private func createImageView(with image: UIImage?, width: CGFloat, height: CGFloat, cornerRadius: CGFloat) -> UIImageView {
		let imageView = UIImageView()
		imageView.image = image
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = cornerRadius
		imageView.clipsToBounds = true
		imageView.snp.makeConstraints { make in
			make.width.equalTo(width)
			make.height.equalTo(height)
		}
		return imageView
	}

	private func setupConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(16)
			make.leading.equalToSuperview().offset(16)
			make.trailing.equalTo(imagesStackView.snp.leading).offset(-16)
		}

		subtitleLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(8)
			make.leading.equalToSuperview().offset(16)
			make.trailing.equalTo(imagesStackView.snp.leading)
		}

		imagesStackView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(16)
			make.trailing.equalToSuperview().offset(-16)
			make.bottom.equalToSuperview().offset(-16)
			make.width.equalTo(98)
		}
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		if let gradientLayer = layer.sublayers?.first as? CAGradientLayer {
			gradientLayer.frame = bounds
		}
	}
}


