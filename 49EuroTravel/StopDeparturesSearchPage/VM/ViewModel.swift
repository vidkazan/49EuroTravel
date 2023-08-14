//
//  oldViewModel.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 05.05.23.
//

import Foundation



class SearchLocationViewControllerViewModel {
	var journeySearchData = JourneySearchData()
	var onStateChange : ((SearchControllerStates) -> Void)?
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
			self.resultJourneysViewDataSourse = nil
			DispatchQueue.main.async {
				self.constructJourneysData()
			}
		}
	}
	var resultJourneysViewDataSourse : ResultJourneyViewDataSourse? {
		didSet {
			self.state = .onNewDataJourney
		}
	}
	var previousSearchLineString = ""
	
	init(){
		self.state = .onStart
	}
}


extension SearchLocationViewControllerViewModel {
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
		if journeySearchData.updateSearchStopData(type: type, stop: stop) == true {
			self.fetchJourneys()
		}
	}
	func updateJourneyTimeValue(date : Date?){
		if journeySearchData.updateSearchTimeData(departureTime: date) == true {
			self.fetchJourneys()
		}
	}
}
