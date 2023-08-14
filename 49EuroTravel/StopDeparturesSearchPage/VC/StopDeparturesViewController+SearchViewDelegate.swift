//
//  S.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import UIKit

extension SearchLocationViewController : SearchViewDelegate {
	func stopCellDidPressed(stop : Stop, type: LocationDirectionType) {
		self.viewModel.updateSearchData(stop: stop, type: type)
	}
	func textFieldDidChange(text: String, type : LocationDirectionType) {
		switch type {
		case .departure:
			switch text.count {
			case 0:
				viewModel.searchLocationDataDeparture = []
			default:
				viewModel.updateSearchText(text: text, isDeparture: true)
			}
		case .arrival:
			switch text.count {
			case 0:
				viewModel.searchLocationDataArrival = []
			default:
				viewModel.updateSearchText(text: text, isDeparture: false)
			}
		}
	}
}


extension SearchLocationViewController : TimeChooseViewDelegate {
	func timeDidChanged(date: Date) {
		viewModel.updateJourneyTimeValue(date: date)
		prints(DateParcer.getTimeAndDateStringFromDate(date: date))
		self.timeControl.setTitle(DateParcer.getTimeAndDateStringFromDate(date: date), forSegmentAt: 1)
		self.timeControl.setNeedsLayout()
		self.timeControl.layoutIfNeeded()
	}
}
