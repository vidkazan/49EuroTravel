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
	
	mutating func updateData(type: LocationDirectionType, stop : Stop) -> Bool {
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
	
	init(){
		self.state = .onStart
	}
	
	func updateSearchText(text : String?,isDeparture : Bool){
		guard let text = text else { return }
		if text.count > 2 && text.count > self.previousSearchLineString.count {
			prints(text)
			prints(self.previousSearchLineString)
			self.state = .onLoading
			fetchLocations(text: text,isDeparture : isDeparture)
		}
		self.previousSearchLineString = text
	}
	
	func updateSearchData(stop : Stop, type : LocationDirectionType){
		if journeySearchData.updateData(type: type, stop: stop) == false {
			return
		}
		print("wohooo")
	}

//	func fetchDepartures(){
//		var query : [URLQueryItem] = []
//		query = Query.getQueryItems(methods: [
//			Query.duration(minutes: 20),
//			Query.national(icTrains: false),
//			Query.nationalExpress(iceTrains: false),
//			Query.pretty(pretyIntend: false),
//			Query.remarks(showRemarks: true),
//			Query.subway(uBahn: false),
//			Query.taxi(taxi: false),
//			Query.bus(bus: false)
//		])
//		ApiService.fetch(Departures.self,query: query, type: ApiService.Requests.stopDepartures(stopId: Constants.stopIdNeuss),requestGroupId: "") { [self] result in
//			switch result {
//			case .success(let res) :
//				self.searchUsersData = res.departures
//			case .failure(let error) :
//				self.state = .onError(error: error, indexPath: nil)
// 			}
//		}
//	}
	
	
//	func fetchJourneys(){
//		var query : [URLQueryItem] = []
//		query = Query.getQueryItems(methods: [
//			Query.duration(minutes: 20),
//			Query.national(icTrains: false),
//			Query.nationalExpress(iceTrains: false),
//			Query.pretty(pretyIntend: false),
//			Query.remarks(showRemarks: true),
//			Query.subway(uBahn: false),
//			Query.taxi(taxi: false),
//			Query.bus(bus: false)
//		])
//		ApiService.fetch(Departures.self,query: query, type: ApiService.Requests.stopDepartures(stopId: Constants.stopIdNeuss),requestGroupId: "") { [self] result in
//			switch result {
//			case .success(let res) :
//				self.searchUsersData = res.departures
//			case .failure(let error) :
//				self.state = .onError(error: error, indexPath: nil)
//			}
//		}
//	}
}

extension SearchLocationViewControllerViewModel {
	private func fetchLocations(text : String?, isDeparture : Bool){
		guard let text = text else { return }
		if text.count < 2 { return }
		var query : [URLQueryItem] = []
		query = Query.getQueryItems(methods: [
			Query.location(location: text),
			Query.results(max: 10)
		])
		ApiService.fetch([Stop].self,query: query, type: ApiService.Requests.locations(name: text ),requestGroupId: "") { [self] result in
			switch result {
			case .success(let res) :
				switch isDeparture {
				case true:
					self.searchLocationDataDeparture = res
				case false:
					self.searchLocationDataArrival = res
				}
			case .failure(let error) :
				self.state = .onError(error: error, indexPath: nil)
			}
		}
	}
}
