//
//  DataSourse.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import Foundation

struct SearchLocationData {
	let type : LocationDirectionType
	let stop : Stop
	
	init(type: LocationDirectionType, stop : Stop) {
		self.type = type
		self.stop = stop
	}
}

struct JourneySearchData {
	var departure : SearchLocationData?
	var arrival : SearchLocationData?
	
	mutating func updateSearchData(type: LocationDirectionType, stop : Stop) -> Bool {
		switch type {
		case .departure:
			self.departure =  SearchLocationData(type: .departure, stop: stop)
		case .arrival:
			self.arrival =  SearchLocationData(type: .arrival, stop : stop)
		}
		if self.arrival != nil && self.departure != nil {
			return true
		}
		return false
	}
}
