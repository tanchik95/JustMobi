//
//  PhotoAlbumViewController.swift
//  JustMobi
//
//  Created by Татьяна Исаева on 01.11.2024.
//


import UIKit

final class PhotoAlbumViewController: UIViewController {
	
	private lazy var customView: PhotoAlbumCustomView = .init()


	// MARK: - Object lifecycle
	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func loadView() {
		view = customView
	}
}


