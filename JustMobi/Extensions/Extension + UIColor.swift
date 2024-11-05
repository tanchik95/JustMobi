//
//  Extension + UIColor.swift
//  JustMobi
//
//  Created by Татьяна Исаева on 30.10.2024.
//

import UIKit

extension UIColor {
	convenience init(hex: String) {
		var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
		if hexString.hasPrefix("#") {
			hexString.remove(at: hexString.startIndex)
		}

		var rgbValue: UInt64 = 0
		Scanner(string: hexString).scanHexInt64(&rgbValue)

		self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
				  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
				  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
				  alpha: 1.0)
	}
}
