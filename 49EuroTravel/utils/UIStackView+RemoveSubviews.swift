//
//  UIStackView+RemoveSubviews.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 07.08.23.
//

import UIKit
extension UIStackView {
	func removeArrangedSubviews() {
		arrangedSubviews.forEach(removeArrangedSubview)
		subviews.forEach { $0.removeFromSuperview() }
	}
}
