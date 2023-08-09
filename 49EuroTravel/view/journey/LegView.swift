//
//  JourneyLegView.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import UIKit

class LegView: UIView {
	let label : UILabel = {
		let l = UILabel()
		l.textColor = .white
		l.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
		l.numberOfLines = 2
//		l.lineBreakMode = .
		return l
	}()
	init(name : String, color : UIColor) {
		super.init(frame: .zero)
		self.label.text = name
		self.backgroundColor = color
		self.layer.borderWidth = 1
		self.layer.borderColor = UIColor.black.cgColor
		self.layer.cornerRadius = Constants.CornerRadius.tiny
		setupUI()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupUI(){
		self.addSubview(label)
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
	}
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
