//
//  JourneyView.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import UIKit

class ResultJourneysView: UIView {
	let timeline = TimelineView()
	let journey0 = JourneyView()
	let currentTimeLine = CurrentTimeLineView()
	init() {
		super.init(frame: .zero)
		self.backgroundColor = Constants.Gray49
		self.layer.cornerRadius = Constants.CornerRadius.small
		setupUI()
	}
	func configure(data: ResultJourneyViewDataSourse?){
		guard let data = data else { return }
		self.timeline.configure(data: data.timeline)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupUI(){
		self.addSubview(timeline)
		self.addSubview(journey0)
//		self.addSubview(currentTimeLine)
		
		timeline.translatesAutoresizingMaskIntoConstraints = false
		timeline.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
		timeline.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
		timeline.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
		timeline.widthAnchor.constraint(equalToConstant: 40).isActive = true
		
		journey0.translatesAutoresizingMaskIntoConstraints = false
		journey0.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
		journey0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
		journey0.leadingAnchor.constraint(equalTo: timeline.trailingAnchor, constant: 5).isActive = true
		journey0.widthAnchor.constraint(equalToConstant: 40).isActive = true
		
//		currentTimeLine.translatesAutoresizingMaskIntoConstraints = false
//		currentTimeLine.topAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
//		currentTimeLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
//		currentTimeLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2).isActive = true
	}
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
