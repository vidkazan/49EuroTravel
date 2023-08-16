//
//  ViewDataSourse.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import Foundation
import UIKit

enum badgesList {
	case price(price: String)
	case dticket
	case cancelled
	case connectionNotReachable
}

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

struct JourneyCollectionViewDataSourse : Equatable {
	let startTimeLabelText : String
	let endTimeLabelText : String
	let durationLabelText : String
	let legs : [LegViewDataSourse]
}

struct JourneyViewDataSourse : Equatable {
	let legs : [LegViewDataSourse]
}

struct AllJourneysCollectionViewDataSourse : Equatable {
	let awaitingData : Bool
	let journeys : [JourneyCollectionViewDataSourse]
}

struct ResultJourneyViewDataSourse : Equatable {
	let awaitingData : Bool
	let journeys : [JourneyViewDataSourse]?
	let timeline : TimelineViewDataSourse?
}
