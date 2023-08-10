//
//  JourneyView.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import UIKit

class JourneyView: UIView {
	var workingViews : [UIView] = []
	let bg : UIView = {
		let view = UIView()
		view.backgroundColor = .systemGray4
		view.layer.cornerRadius = Constants.CornerRadius.tiny
		return view
	}()
	init() {
		super.init(frame: .zero)
		self.layer.cornerRadius = Constants.CornerRadius.tiny
	}
	func configure(data: JourneyViewDataSourse?){
		
		guard let data = data  else {
			for view in workingViews {
				view.removeFromSuperview()
			}
			bg.removeFromSuperview()
			return
		}
		let topPosition = data.legs[0].legTopPosition
		self.addSubview(bg)
		var lastPosition : Double?
		for leg in data.legs {
			let leg0 = LegView(name: leg.name, color: UIColor.CompanionColors.secondary)
			lastPosition = leg.legBottomPosition
			workingViews.append(leg0)
			self.addSubview(leg0)
			leg0.translatesAutoresizingMaskIntoConstraints = false
			leg0.topAnchor.constraint(equalTo: self.topAnchor,constant: self.bounds.height * leg.legTopPosition).isActive = true
			leg0.bottomAnchor.constraint(equalTo: self.topAnchor,constant: self.bounds.height * leg.legBottomPosition).isActive = true
			leg0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
			leg0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		}
		bg.translatesAutoresizingMaskIntoConstraints = false
		bg.topAnchor.constraint(equalTo: self.topAnchor,constant: self.bounds.height * topPosition).isActive = true
		bg.bottomAnchor.constraint(equalTo: self.topAnchor,constant: self.bounds.height * (lastPosition ?? 1)).isActive = true
		bg.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
		bg.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
