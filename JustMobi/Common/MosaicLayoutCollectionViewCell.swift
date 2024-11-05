//
//  MosaicLayoutCollectionViewCell.swift
//  JustMobi
//
//  Created by Татьяна Исаева on 01.11.2024.
//

import UIKit

public class MosaicLayoutCollectionViewCell: UICollectionViewCell {

	public static let reuseId = "MosaicLayoutCollectionViewCell"

	// MARK: - UI elements
	private var elementsContainer: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.clipsToBounds = true
		return view
	}()

	private var photoImage: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.backgroundColor = .clear
		imageView.clipsToBounds = true
		return imageView
	}()

	private var imageHeight: CGFloat = 0

	public override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}

	private func setup() {
		addSubview(elementsContainer)
		elementsContainer.snp.remakeConstraints { make in
			make.height.width.equalToSuperview()
			make.center.equalToSuperview()
		}

		elementsContainer.layer.cornerRadius = frame.width / 8
		elementsContainer.layer.borderWidth = 3.0
		elementsContainer.layer.borderColor = UIColor.white.cgColor
	}

	private func configureImage() {
		elementsContainer.addSubview(photoImage)
		photoImage.snp.remakeConstraints { make in
			make.top.leading.trailing.equalToSuperview()
			make.height.equalTo(imageHeight)
		}
	}


	public override func prepareForReuse() {
		photoImage.image = nil
	}

	public func set(imageString: String) {
		photoImage.image = UIImage(named: imageString)

		configureImage()
	}

	public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
		super.apply(layoutAttributes)

		guard let attributes = layoutAttributes as? MosaicLayoutAttributes else { return }
		imageHeight = attributes.imageHeight
	}
}
