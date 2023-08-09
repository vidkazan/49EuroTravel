//
//  ViewModel+ConstructJourneyData.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import Foundation

extension SearchLocationViewControllerViewModel {
	
	private func getTimeLabelPosition(firstTS : Date?, lastTS: Date?, currentTS: Date?) -> Double?{
		guard let firstTS = firstTS, let lastTS = lastTS, let currentTS = currentTS else { return nil }
		let fTs = firstTS.timeIntervalSinceReferenceDate
		let lTs = lastTS.timeIntervalSinceReferenceDate
		let cTs = currentTS.timeIntervalSinceReferenceDate
		let ext = (lTs - fTs) * 0.05
		
		let fTsExtended = fTs - ext
		let lTsExtended = lTs + ext
		
		let diffExtended = lTsExtended - fTsExtended
		
		let cDiff = cTs - fTsExtended
		
		return cDiff / diffExtended
	}
	
	func constructTimelineData(){
		
	}
	
	func constructJourneyData(){
		guard let src = self.journeysData else { return }
		guard let journeys = src.journeys else { return }
		guard let firstJourney = journeys.first else { return }
		guard let firstJourneyLegs = firstJourney.legs else { return }
		guard let firstJourneyFirstLeg = firstJourneyLegs.first else { return }
		guard let firstJourneyLastLeg = firstJourneyLegs.last else { return }
		guard let firstTimestamp = firstJourneyFirstLeg.departure else { return }
		guard let lastTimestamp = firstJourneyLastLeg.plannedArrival else { return }
		
		
		
		
		let time1 = DateParcer.getDateFromDateString(dateString: firstTimestamp)
		
		let time2 = DateParcer.getDateFromDateString(dateString: lastTimestamp)
		
		let tl = TimelineViewDataSourse(timeLabels: [
			TimelineTimeLabelDataSourse(
				text: DateParcer.getTimeStringFromDate(date: time1!),
				textCenterYposition: self.getTimeLabelPosition(
					firstTS: time1,
					lastTS: time2,
					currentTS: time1)!
			),
			TimelineTimeLabelDataSourse(
				text: DateParcer.getTimeStringFromDate(date: time2!),
				textCenterYposition: self.getTimeLabelPosition(
					firstTS: time1,
					lastTS: time2,
					currentTS: time2)!
			)
		])
		
		var legsDataSourse : [LegViewDataSourse] = []
		
		for leg in firstJourneyLegs {
			let startTS = DateParcer.getDateFromDateString(dateString: leg.plannedDeparture!)
			let endTS = DateParcer.getDateFromDateString(dateString: leg.plannedArrival!)
			legsDataSourse.append(LegViewDataSourse(
				name: leg.line?.name ?? "",
				legTopPosition: getTimeLabelPosition(
					firstTS: time1,
					lastTS: time2,
					currentTS: startTS
				) ?? 0,
				legBottomPosition: getTimeLabelPosition(
					firstTS: time1,
					lastTS: time2,
					currentTS: endTS
				) ?? 0
			)
		)}
		
		let journey = JourneyViewDataSourse(legs: legsDataSourse)
		
		let res = ResultJourneyViewDataSourse(journeys: [journey], timeline: tl)
		
		self.resultJourneysViewDataSourse = res
	}
}
