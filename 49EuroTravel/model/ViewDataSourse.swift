//
//  ViewDataSourse.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import Foundation
import UIKit

struct TimelineTimeLabelDataSourse : Equatable {
	let text : String
	let textCenterYposition : Double
}

struct TimelineViewDataSourse : Equatable {
	let timeLabels : [TimelineTimeLabelDataSourse]
}

struct LegViewDataSourse : Equatable {
	let name : String
	let legTopPosition : Double
	let legBottomPosition : Double
	var color : UIColor
}

struct JourneyViewDataSourse : Equatable {
	let legs : [LegViewDataSourse]
}

struct ResultJourneyViewDataSourse : Equatable {
	let awaitingData : Bool
	let journeys : [JourneyViewDataSourse]?
	let timeline : TimelineViewDataSourse?
}








