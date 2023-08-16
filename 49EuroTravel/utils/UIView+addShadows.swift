//
//  UIView+addShadows.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 16.08.23.
//

import UIKit

extension UIView {

	func addShadow(offset: CGSize = CGSize(width: 1, height: 3), color: CGColor = UIColor.black.cgColor, radius: CGFloat = 1, opacity: Float = 0.3) {
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize(width: 0, height: 3)
		layer.shadowRadius = 2
		layer.shadowOpacity = 0.20
		layer.masksToBounds = false
		layer.shouldRasterize = true
		layer.rasterizationScale = UIScreen.main.scale
		
		
		let backgroundCGColor = backgroundColor?.cgColor
		backgroundColor = nil
		layer.backgroundColor =  backgroundCGColor
	}
}
