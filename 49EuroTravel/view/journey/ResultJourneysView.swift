//
//  JourneyView.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import UIKit

class ResultJourneysView: UIView {
	var timeline = TimelineView()
	let journey0 = JourneyView()
	var currentTimeLine = CurrentTimeLineView()
	init() {
		super.init(frame: .zero)
		self.backgroundColor = Constants.Gray49
		self.layer.cornerRadius = Constants.CornerRadius.small
		setupUI()
	}
	func configure(data: ResultJourneyViewDataSourse?){
		guard let data = data else {
			self.timeline.configure(data: nil)
			self.journey0.configure(data: nil)
			return
		}
		self.timeline.configure(data: data.timeline)
		self.journey0.configure(data: data.journeys[0])
//		for (index,journey) in data.journeys.enumerated() {
//			
//		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupUI(){
		self.addSubview(timeline)
		self.addSubview(journey0)
		journey0.translatesAutoresizingMaskIntoConstraints = false
		journey0.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		journey0.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		journey0.leadingAnchor.constraint(equalTo: timeline.trailingAnchor, constant:5) .isActive = true
		journey0.widthAnchor.constraint(equalToConstant: 60).isActive = true
//		self.addSubview(currentTimeLine)
		
		timeline.translatesAutoresizingMaskIntoConstraints = false
		timeline.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
		timeline.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
		timeline.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
		timeline.widthAnchor.constraint(equalToConstant: 40).isActive = true
		
//		currentTimeLine.translatesAutoresizingMaskIntoConstraints = false
//		currentTimeLine.topAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
//		currentTimeLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
//		currentTimeLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2).isActive = true
	}
}
