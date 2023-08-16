//
//  JourneyCellHeaderView.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 16.08.23.
//

import UIKit

class JourneyCellHeaderView: UIView {
	var startTimeLabel : UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
		label.textColor = UIColor(hue: 0, saturation: 0, brightness: 0.1, alpha: 1)
		label.text = "66:66"
		return label
	}()
	var durationLabel : UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
		label.textColor = UIColor(hue: 0, saturation: 0, brightness: 0.1, alpha: 1)
		label.text = "11h 11min"
		return label
		
	}()
	var finishTimeLabel : UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
		label.textColor = UIColor(hue: 0, saturation: 0, brightness: 0.1, alpha: 1)
		label.text = "77:77"
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.addSubview(startTimeLabel)
		self.addSubview(durationLabel)
		self.addSubview(finishTimeLabel)
		
		startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
		startTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10).isActive = true
		startTimeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		
		durationLabel.translatesAutoresizingMaskIntoConstraints = false
		durationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		durationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		
		finishTimeLabel.translatesAutoresizingMaskIntoConstraints = false
		finishTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10).isActive = true
		finishTimeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
	}
	
	func configure(data: JourneyCollectionViewDataSourse){
		self.durationLabel.text = data.durationLabelText
		self.startTimeLabel.text = data.startTimeLabelText
		self.finishTimeLabel.text = data.endTimeLabelText
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
