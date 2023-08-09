//
//  oldViewModel.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 05.05.23.
//

import Foundation

struct SearchLocationData{
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

enum SearchControllerStates {
	case onStart
	case onLoading
	case onNewDataDepartureStop
	case onNewDataArrivalStop
	case onNewDataJourney
	case onError(error : ApiServiceErrors, indexPath : IndexPath?)
	
	var description : String {
		switch self {
		case .onStart:
			return "onStart"
		case .onLoading:
			return "onLoading"
		case .onNewDataDepartureStop:
			return "onNewDataDepartureStop"
		case .onNewDataArrivalStop:
			return "onNewDataArrivalStop"
		case .onError:
			return "onError"
		case .onNewDataJourney:
			return "onNewDataJourney"
		}
	}
}

class SearchLocationViewControllerViewModel {
	
	var journeySearchData = JourneySearchData()
	var onStateChange : ((SearchControllerStates) -> Void)?
	var previousSearchLineString = ""
	
	var state : SearchControllerStates {
		didSet {
			prints("state: ",state.description)
			self.onStateChange?(self.state)
		}
	}
	var searchLocationDataDeparture : [Stop] = []  {
		didSet {
			self.state = .onNewDataDepartureStop
		}
	}
	var searchLocationDataArrival : [Stop] = []  {
		didSet {
			self.state = .onNewDataArrivalStop
		}
	}
	var journeysData : JourneysContainer? {
		didSet {
			DispatchQueue.main.async {
				self.constructJourneyData()
			}
		}
	}
	var resultJourneysViewDataSourse : ResultJourneyViewDataSourse? {
		didSet {
			self.state = .onNewDataJourney
		}
	}
	
	
	init(){
		self.state = .onStart
	}
	
	func updateSearchText(text : String?,isDeparture : Bool){
		guard let text = text else { return }
		if text.count > 2 && text.count > self.previousSearchLineString.count {
			prints(text)
			prints(self.previousSearchLineString)
			self.state = .onLoading
			self.fetchLocations(text: text,isDeparture : isDeparture)
		}
		self.previousSearchLineString = text
	}
	
	func updateSearchData(stop : Stop, type : LocationDirectionType){
		if journeySearchData.updateSearchData(type: type, stop: stop) == true {
			self.fetchJourneys()
		}
	}
}

