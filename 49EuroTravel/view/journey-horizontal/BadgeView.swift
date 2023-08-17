//
//  BadgeView.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 17.08.23.
//

import UIKit

struct BadgeDataSource : Equatable {
	let color : UIColor
	let name : String
	
	init(color : UIColor, name : String){
		self.name = name
		self.color = color
	}
}

class BadgeView: UIView {
	init(badge : BadgeDataSource) {
		self.kind.text = badge.name
		self.kind.backgroundColor = badge.color
		super.init(frame: .zero)
		setupViews()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	let kind : PaddingLabel = {
		let date = PaddingLabel(inset: 6)
		date.font = date.font.withSize(12)
		date.layer.masksToBounds = true
		date.textColor = .white
		date.layer.cornerRadius = Constants.CornerRadius.small
		return date
	}()
	
	func setupViews(){
		self.layer.cornerRadius = Constants.CornerRadius.small
		addSubview(kind)
		
		kind.translatesAutoresizingMaskIntoConstraints = false
		kind.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		kind.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		kind.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		kind.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		kind.textAlignment = .center
	}
	
}
