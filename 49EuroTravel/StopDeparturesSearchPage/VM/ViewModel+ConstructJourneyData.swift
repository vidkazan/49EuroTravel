//
//  ViewModel+ConstructJourneyData.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import Foundation
import UIKit

extension SearchLocationViewControllerViewModel {
	
	private func getTimeLabelPosition(firstTS : Date?, lastTS: Date?, currentTS: Date?) -> Double?{
		guard let firstTS = firstTS, let lastTS = lastTS, let currentTS = currentTS else { return nil }
		let fTs = firstTS.timeIntervalSinceReferenceDate
		let lTs = lastTS.timeIntervalSinceReferenceDate
		let cTs = currentTS.timeIntervalSinceReferenceDate
		let ext = (lTs - fTs) * 0.02
		
		let fTsExtended = fTs - ext
		let lTsExtended = lTs + ext
		
		let diffExtended = lTsExtended - fTsExtended
		
		let cDiff = cTs - fTsExtended
		
		return cDiff / diffExtended
	}
	
	private func constructTimelineTimelabelData(firstTS: Date?,lastTS: Date?,currentTS: Date?) -> TimelineTimeLabelDataSourse? {
		guard let firstTS = firstTS, let lastTS = lastTS, let currentTS = currentTS else { return nil }
		let tl = TimelineTimeLabelDataSourse(
			text: DateParcer.getTimeStringFromDate(date: currentTS),
			   textCenterYposition: self.getTimeLabelPosition(
				   firstTS: firstTS,
				   lastTS: lastTS,
				   currentTS: currentTS)!)
		return tl
	}
	
	private func constructTimelineData(firstTS: Date?,lastTS: Date?) -> TimelineViewDataSourse? {
		let tl = TimelineViewDataSourse(timeLabels: [
			self.constructTimelineTimelabelData(firstTS: firstTS, lastTS: lastTS, currentTS: firstTS)!,
			self.constructTimelineTimelabelData(firstTS: firstTS, lastTS: lastTS, currentTS: lastTS)!
		])
		return tl
	}
	
	func constructLegData(leg : Leg,firstTS: Date?, lastTS: Date?) -> LegViewDataSourse? {
		guard
			let startTSString = leg.plannedDeparture,
			let endTSString = leg.plannedArrival,
			let lineName = leg.line?.name else { return nil }
		
		let startTS = DateParcer.getDateFromDateString(dateString: startTSString)
		let endTS = DateParcer.getDateFromDateString(dateString: endTSString)
		
		guard let legTopPosition = getTimeLabelPosition( firstTS: firstTS, lastTS: lastTS,	currentTS: startTS),
			  let legBottomPosition = getTimeLabelPosition( firstTS: firstTS, lastTS: lastTS,	currentTS: endTS) else { return nil }
		
		let res = LegViewDataSourse(
			name: lineName,
			legTopPosition: legTopPosition,
			legBottomPosition: legBottomPosition,
			color: ((leg.arrivalDelay != nil && leg.arrivalDelay! > 0) ? UIColor.CompanionColors.red : UIColor.CompanionColors.secondary)
		)
		return res
	}
	
	func constructJourneyData(journey : Journey, firstTS: Date?, lastTS: Date?) -> JourneyViewDataSourse? {
		var legsDataSourse : [LegViewDataSourse] = []
		guard let legs = journey.legs else { return nil }
		for leg in legs {
			if let res = self.constructLegData(leg: leg, firstTS: firstTS, lastTS: lastTS) {
				legsDataSourse.append(res)
			}
		}
		return JourneyViewDataSourse(legs: legsDataSourse)
	}
	
	func constructJourneysData(){
		guard let src = self.journeysData else { return }
		guard let journeys = src.journeys else { return }
		guard let firstJourney = journeys.first else { return }
		guard let lastJourney = journeys.last else { return }
		guard let firstJourneyLegs = firstJourney.legs else { return }
		guard let lastJourneyLegs = lastJourney.legs else { return }
		
		guard let firstJourneyFirstLeg = firstJourneyLegs.first else { return }
		guard let firstJourneyLastLeg = firstJourneyLegs.last else { return }
		guard let lastJourneyLastLeg = lastJourneyLegs.last else { return }

		
		guard let firstTimestamp = firstJourneyFirstLeg.plannedDeparture else { return }
		guard let lastTimestampFirstTrip = firstJourneyLastLeg.plannedArrival else { return }
		guard let lastTimestamp = lastJourneyLastLeg.plannedArrival else { return }
		
		let firstTS = DateParcer.getDateFromDateString(dateString: firstTimestamp)
		let lastFromFirstJourneyTS = DateParcer.getDateFromDateString(dateString: lastTimestampFirstTrip)
		let lastTS = DateParcer.getDateFromDateString(dateString: lastTimestamp)
		
		var journeysViewData : [JourneyViewDataSourse] = []
		for journey in journeys {
		if let res = self.constructJourneyData(journey: journey, firstTS: firstTS, lastTS: lastTS) {
				journeysViewData.append(res)
			}
		}
		
		guard let tl = self.constructTimelineData(firstTS: firstTS, lastTS: lastTS) else { return }
		
		prints(Double(UIScreen.main.bounds.height) / Double(DateParcer.getTwoDateIntervalInMinutes(date1: lastTS, date2: firstTS)!),
			   Double(UIScreen.main.bounds.height) / Double(DateParcer.getTwoDateIntervalInMinutes(date1: lastFromFirstJourneyTS, date2: firstTS)!))
		
		self.resultJourneysViewDataSourse = ResultJourneyViewDataSourse(
			journeys: journeysViewData,
			timeline: tl
		)
	}
}
