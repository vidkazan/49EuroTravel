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
		var lastPosition : Double = 0
		for (index,leg) in data.legs.enumerated() {
			let leg0 = LegView(name: leg.name, color: leg.color)
			lastPosition = leg.legBottomPosition
			workingViews.append(leg0)
			self.addSubview(leg0)
			leg0.translatesAutoresizingMaskIntoConstraints = false
			leg0.topAnchor.constraint(equalTo: self.topAnchor,constant: self.bounds.height * leg.legTopPosition).isActive = true
			leg0.bottomAnchor.constraint(equalTo: self.topAnchor,constant: self.bounds.height * leg.legBottomPosition).isActive = true
			leg0.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
			switch index.isMultiple(of: 2){
			case true:
				leg0.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
			case false:
				leg0.widthAnchor.constraint(equalTo: self.widthAnchor,constant: -5).isActive = true
			}
			
		}
		bg.translatesAutoresizingMaskIntoConstraints = false
		bg.topAnchor.constraint(equalTo: self.topAnchor,constant: self.bounds.height * topPosition).isActive = true
		bg.bottomAnchor.constraint(equalTo: self.topAnchor,constant: self.bounds.height * lastPosition).isActive = true
		bg.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
		bg.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class HorizontalJourneyView: PrintUIView {
	var workingViews : [UIView] = []
	let bg : UIView = {
		let view = UIView()
		view.backgroundColor = .systemGray4
//		view.layer.cornerRadius = Constants.CornerRadius.tiny
		return view
	}()
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.layer.cornerRadius = Constants.CornerRadius.tiny
	}
	
	func configure(data: JourneyCollectionViewDataSourse?){
		prints("bounds LegsView",self.bounds)
		for view in workingViews {
			view.removeFromSuperview()
		}
		bg.removeFromSuperview()
		guard let data = data else { return }
		
		let topPosition = data.legs[0].legTopPosition
		self.addSubview(bg)
		var lastPosition : Double = 0
		for (_,leg) in data.legs.enumerated() {
			let leg0 = LegView(name: leg.name, color: leg.color)
			if Int(leg.name.count * 7) > Int(self.bounds.width * (leg.legBottomPosition - leg.legTopPosition)) {
				leg0.label.text = ""
			}
			lastPosition = leg.legBottomPosition
			workingViews.append(leg0)
			self.addSubview(leg0)
			leg0.translatesAutoresizingMaskIntoConstraints = false
			leg0.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: self.bounds.width * leg.legTopPosition).isActive = true
			leg0.trailingAnchor.constraint(equalTo: self.leadingAnchor,constant: self.bounds.width * leg.legBottomPosition).isActive = true
			leg0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//			switch index.isMultiple(of: 2){
//			case true:
				leg0.heightAnchor.constraint(equalTo: self.heightAnchor,constant: -20).isActive = true
//			case false:
//				leg0.heightAnchor.constraint(equalTo: self.heightAnchor,constant: -5).isActive = true
//			}
			
		}
		bg.translatesAutoresizingMaskIntoConstraints = false
		bg.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.bounds.width * topPosition).isActive = true
		bg.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.bounds.width * lastPosition).isActive = true
		bg.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		bg.heightAnchor.constraint(equalToConstant: 20).isActive = true
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

