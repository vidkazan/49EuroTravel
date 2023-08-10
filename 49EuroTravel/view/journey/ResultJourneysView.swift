//
//  JourneyView.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import UIKit

class ResultJourneysView: UIView {
	var timeline = TimelineView()
	var journeys : [JourneyView] = []
	var currentTimeLine = CurrentTimeLineView()
	init() {
		super.init(frame: .zero)
		self.backgroundColor = Constants.Gray49
		self.layer.cornerRadius = Constants.CornerRadius.small
		for _ in 0...4 {
			journeys.append(JourneyView())
		}
		setupUI()
	}
	func configure(data: ResultJourneyViewDataSourse?){
		guard let data = data else {
			self.timeline.configure(data: nil)
			for journey in self.journeys {
				journey.configure(data: nil)
			}
			return
		}
		
		self.timeline.configure(data: data.timeline)
		for (index,journeyData) in data.journeys.enumerated() {
			journeys[index].configure(data: journeyData)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupUI(){
		self.addSubview(timeline)
		for (index,journey) in self.journeys.enumerated() {
			self.addSubview(journey)
			journey.translatesAutoresizingMaskIntoConstraints = false
			journey.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
			journey.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
			journey.leadingAnchor.constraint(equalTo: timeline.trailingAnchor, constant:CGFloat(5+(65 * index))).isActive = true
			journey.widthAnchor.constraint(equalToConstant: 60).isActive = true
		}
		
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
