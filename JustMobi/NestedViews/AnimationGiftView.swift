//
//  AnimationGiftView.swift
//  JustMobi
//
//  Created by Татьяна Исаева on 30.10.2024.
//

import UIKit
import SnapKit

final class AnimationGiftView: UIView {

	// MARK: - Private properties
	
	private let giftBoxView = UIImageView()
	private let timerLabel = UILabel()
	private var stars: [UIImageView] = []
	private var countdownTimer: Timer?
	private var remainingSeconds: Int = 1514

	// MARK: - Object lifecycle
	
	convenience init() {
		self.init(frame: .zero)
		setupView()
		startAnimation()
		startCountdown()
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = bounds.width / 2
		layer.masksToBounds = true
	}

	private func setupView() {
		backgroundColor = UIColor.black.withAlphaComponent(0.6)

		giftBoxView.image = UIImage(named: "gift")
		giftBoxView.tintColor = UIColor.init(hex: "#A52A2A")
		addSubview(giftBoxView)
		giftBoxView.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.width.height.equalTo(60)
		}

		timerLabel.textColor = .white
		timerLabel.font = .systemFont(ofSize: 14, weight: .bold)
		timerLabel.textAlignment = .center
		addSubview(timerLabel)
		timerLabel.snp.makeConstraints { make in
			make.top.equalTo(giftBoxView.snp.bottom).offset(20)
			make.centerX.equalToSuperview()
		}

		for _ in 0..<5 {
			let star = UIImageView(image: UIImage(systemName: "star.fill"))
			star.tintColor = .systemYellow
			star.alpha = 0
			addSubview(star)
			stars.append(star)
		}

		let radius: CGFloat = 50
		for (index, star) in stars.enumerated() {
			let angle = (2.0 * .pi * 2.3 * CGFloat(index)) / CGFloat(stars.count)
			let x = cos(angle) * radius
			let y = sin(angle) * radius

			star.snp.makeConstraints { make in
				make.center.equalTo(giftBoxView)
				make.width.height.equalTo(20)
				star.transform = CGAffineTransform(translationX: x, y: y)
			}
		}
	}

	private func startAnimation() {
		shakeGiftBox()
		animateStars()
	}

	private func shakeGiftBox() {
		let shakeAnimation = CAKeyframeAnimation(keyPath: "position")
		shakeAnimation.values = [
			NSValue(cgPoint: CGPoint(x: giftBoxView.center.x - 10, y: giftBoxView.center.y)),
			NSValue(cgPoint: CGPoint(x: giftBoxView.center.x + 10, y: giftBoxView.center.y)),
			NSValue(cgPoint: CGPoint(x: giftBoxView.center.x - 10, y: giftBoxView.center.y)),
			NSValue(cgPoint: CGPoint(x: giftBoxView.center.x, y: giftBoxView.center.y))
		]
		shakeAnimation.keyTimes = [0, 0.25, 0.75, 1]
		shakeAnimation.duration = 0.5
		shakeAnimation.isRemovedOnCompletion = false
		shakeAnimation.fillMode = .forwards

		let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
		rotationAnimation.values = [
			-0.1, 0.1, -0.1, 0
		]
		rotationAnimation.keyTimes = [0, 0.25, 0.75, 1]
		rotationAnimation.duration = 0.5
		rotationAnimation.isRemovedOnCompletion = false
		rotationAnimation.fillMode = .forwards

		let groupAnimation = CAAnimationGroup()
		groupAnimation.animations = [shakeAnimation, rotationAnimation]
		groupAnimation.duration = 0.5
		groupAnimation.isRemovedOnCompletion = false
		groupAnimation.fillMode = .forwards

		giftBoxView.layer.add(groupAnimation, forKey: "shakeAndTilt")
	}

	private func animateStars() {
		let duration: TimeInterval = 2.5

		for (index, star) in stars.enumerated() {
			let delay = duration * Double(index) / Double(stars.count)

			UIView.animate(withDuration: duration / 2, delay: delay, options: [.repeat, .autoreverse], animations: {
				star.alpha = 1.0
				star.transform = star.transform.scaledBy(x: 1.5, y: 1.5)
			}) { _ in

				star.alpha = 0.0
				star.transform = star.transform.scaledBy(x: 1 / 1.5, y: 1 / 1.5)
			}
		}
	}

	private func startCountdown() {
		updateTimerLabel()
		countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
			guard let self = self else { return }
			if self.remainingSeconds > 0 {
				self.remainingSeconds -= 1
				self.updateTimerLabel()

				self.shakeGiftBox()
			} else {
				self.countdownTimer?.invalidate()
			}
		}
	}

	private func updateTimerLabel() {
		let seconds = remainingSeconds % 60
		let minutes = remainingSeconds / 60
		let hours = seconds / 3600
		let remainingSeconds = seconds % 60
		timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
	}

	deinit {
		countdownTimer?.invalidate()
	}
}

