//
//  UIView+addShadows.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 16.08.23.
//

import UIKit

extension UIView {

	func addShadow(offset: CGSize = CGSize(width: 1, height: 3), color: CGColor = UIColor.black.cgColor, radius: CGFloat = 1, opacity: Float = 0.3) {
		layer.shadowColor = color
		layer.shadowOffset = CGSize(width: 1, height: 5)
		layer.shadowRadius = 3
		layer.shadowOpacity = 0.30
		layer.masksToBounds = false
		layer.shouldRasterize = true
		layer.rasterizationScale = UIScreen.main.scale
	}
}
