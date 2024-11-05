//
//  MosaicLayoutCollectionView.swift
//  JustMobi
//
//  Created by Татьяна Исаева on 03.11.2024.
//

import UIKit

public class MosaicLayoutCollectionView: UICollectionView {

	private var images: [PhotoModel] = [
		PhotoModel(imageName: "portrait", width: 168, height: 220),
		PhotoModel(imageName: "autumn", width: 168, height: 260),
		PhotoModel(imageName: "nature", width: 168, height: 200),
		PhotoModel(imageName: "insta_style", width: 168, height: 220),
		PhotoModel(imageName: "people", width: 168, height: 260),
		PhotoModel(imageName: "nature 1", width: 168, height: 220),
		PhotoModel(imageName: "portrait", width: 168, height: 220),
		PhotoModel(imageName: "autumn", width: 168, height: 260)
	]

	// MARK: - Collection view constants
	private let columns: CGFloat = 3.0
	private let inset: CGFloat = 8.0
	private let spacing: CGFloat = 8.0
	private let lineSpacing: CGFloat = 8.0

	public init() {

		let layout = MosaicViewLayout()
		layout.numberOfColumns = 2
		layout.cellPadding = 5

		super.init(frame: .zero, collectionViewLayout: layout)

		delegate = self
		dataSource = self
		layout.delegate = self

		backgroundColor = .black

		showsHorizontalScrollIndicator = false
		showsVerticalScrollIndicator = false

		contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

		register(MosaicLayoutCollectionViewCell.self, forCellWithReuseIdentifier: MosaicLayoutCollectionViewCell.reuseId)
	}

	public func set(images: [PhotoModel]) {
		self.images = images
		contentOffset = .zero
		reloadData()
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}

extension MosaicLayoutCollectionView: UICollectionViewDataSource {
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}

	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let model = images[indexPath.item]
		let cell = dequeueReusableCell(withReuseIdentifier: MosaicLayoutCollectionViewCell.reuseId, for: indexPath) as! MosaicLayoutCollectionViewCell
		cell.set(imageString: model.imageName)

		return cell
	}
}

extension MosaicLayoutCollectionView: UICollectionViewDelegateFlowLayout {
	public func collectionView(_ collectionView: UICollectionView,
							   layout collectionViewLayout: UICollectionViewLayout,
							   sizeForItemAt indexPath: IndexPath) -> CGSize {
		let photoImage = images[indexPath.item]

		return CGSize(width: CGFloat(photoImage.width), height: CGFloat(photoImage.height))
	}


	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
	}

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return spacing
	}

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return lineSpacing
	}
}

extension MosaicLayoutCollectionView: MosaicLayoutDelegate {
	public func collectionView(_ collectionView: UICollectionView,
							   heightForImageAt indexPath: IndexPath,
							   width: CGFloat) -> CGFloat {
		let photoImage = images[indexPath.item]
		let imgWidth = CGFloat(photoImage.width)
		let imgHeight = CGFloat(photoImage.height)

		return width/imgWidth * imgHeight
	}
}
