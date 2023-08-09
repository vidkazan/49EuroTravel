//
//  JourneyView.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import UIKit

class JourneyView: UIView {
	let leg0 = LegView(name: "RE6", color: .red)
	let leg1 = LegView(name: "S1", color: .darkGray)
	let change0 = ChangeView()
	let bg : UIView = {
		let view = UIView()
		view.backgroundColor = .systemGray4
		view.layer.cornerRadius = Constants.CornerRadius.tiny
		return view
	}()
	init() {
		super.init(frame: .zero)
		self.layer.cornerRadius = Constants.CornerRadius.tiny
		setupUI()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupUI(){
		self.addSubview(bg)
		self.addSubview(leg0)
		self.addSubview(leg1)
		
		bg.translatesAutoresizingMaskIntoConstraints = false
		bg.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		bg.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		bg.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
		bg.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true

		leg0.translatesAutoresizingMaskIntoConstraints = false
		leg0.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		leg0.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 150).isActive = true
		leg0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		leg0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		
//		change0.translatesAutoresizingMaskIntoConstraints = false
//		change0.topAnchor.constraint(equalTo: self.topAnchor,constant: 100).isActive = true
//		change0.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 120).isActive = true
//		change0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
//		change0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
		
		leg1.translatesAutoresizingMaskIntoConstraints = false
		leg1.topAnchor.constraint(equalTo: self.topAnchor,constant: 120).isActive = true
		leg1.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
		leg1.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		leg1.widthAnchor.constraint(equalTo: self.widthAnchor,constant: -5).isActive = true
	}
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
