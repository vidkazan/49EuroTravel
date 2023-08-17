//
//  JourneyCellBadgesView.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 16.08.23.
//

import UIKit

class JourneyCellBadgesView: UIView {
	var badges : [BadgeView] = []
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	func configure(data: [BadgesList]){
		var previousBadge : BadgeView? = nil
		
		for badge in badges {
			badge.removeFromSuperview()
		}
		
		for badgeSource in data {
			let badge = badgeSource.badgeView
			self.addSubview(badge)
			badge.translatesAutoresizingMaskIntoConstraints = false
			badge.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
			switch previousBadge == nil {
			case true:
				badge.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5).isActive = true
			case false:
				badge.trailingAnchor.constraint(equalTo: previousBadge!.leadingAnchor ,constant: -5).isActive = true
			}
			previousBadge = badge
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
