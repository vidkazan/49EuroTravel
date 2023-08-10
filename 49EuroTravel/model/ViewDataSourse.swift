//
//  ViewDataSourse.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import Foundation
import UIKit

struct TimelineTimeLabelDataSourse {
	let text : String
	let textCenterYposition : Double
}

struct TimelineViewDataSourse {
	let timeLabels : [TimelineTimeLabelDataSourse]
}

struct LegViewDataSourse {
	let name : String
	let legTopPosition : Double
	let legBottomPosition : Double
	let color : UIColor
}

struct JourneyViewDataSourse {
	let legs : [LegViewDataSourse]
}

struct ResultJourneyViewDataSourse {
	let journeys : [JourneyViewDataSourse]
	let timeline : TimelineViewDataSourse
}








