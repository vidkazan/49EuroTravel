//
//  ViewController.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 05.05.23.
//

import UIKit

class SearchLocationViewController : UIViewController {
	var alert : UIAlertController = {
		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
		alert.title = "Error"
		alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
		return alert
	}()
	var viewModel : SearchLocationViewControllerViewModel
	var datePicker : TimeChoosingView = {
		var datePicker = TimeChoosingView()
		datePicker.isHidden = true
		return datePicker
	}()
	var searchFieldFrom = SearchView(placeholder: "from", image: Constants.locationIcon, type: .departure)
	var searchFieldTo = SearchView(placeholder: "to",image: Constants.flipIcon, type: .arrival)
	var timeControl : CustomSegmentControl = {
		let str = ["now",DateParcer.getTimeAndDateStringFromDate(date: Date.now)]
		let view = CustomSegmentControl(items: str)
		view.selectedSegmentIndex = 0

		return view
	}()
	var resultScrollView : UIScrollView = {
		let view = UIScrollView()
		return view
	}()
	var resultJourneysView = ResultJourneysView()
	
	init(_ viewModel: SearchLocationViewControllerViewModel = SearchLocationViewControllerViewModel() ) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.hideKeyboardWhenTappedAround()
		self.searchFieldFrom.delegate = self
		self.searchFieldTo.delegate = self
		self.datePicker.delegate = self
		self.timeControl.customDelegate = self

		setupUI()
		setupColors()
		DispatchQueue.main.async {
			self.viewModel.onStateChange = { [ weak self ] state in
				switch state {
				case .onStart:
					self?.searchFieldFrom.configure(
						image: Constants.locationIcon,
						stops: [],
						isNotFound: false,
						awaitingData: false
					)
				case .onLoading:
					self?.searchFieldFrom.setLoading()
				case .onNewDataDepartureStop:
					self?.searchFieldFrom.configure(
						image: Constants.locationIcon,
						stops: self?.viewModel.searchLocationDataDeparture ?? [],
						isNotFound: false,
						awaitingData: false
					)
				case .onNewDataArrivalStop:
					self?.searchFieldFrom.setStopLoading()
					self?.searchFieldTo.configure(
						image: Constants.flipIcon,
						stops: self?.viewModel.searchLocationDataArrival ?? [],
						isNotFound: false,
						awaitingData: false
					)
				case .onNewDataJourney:
					self?.resultJourneysView.configure(data: self?.viewModel.resultJourneysViewDataSourse)
				case .onError(error: let error, _: _):
					switch error.apiServiceErrors {
					case .cannotConnectToHost,.cannotDecodeRawData,.cannotDecodeContentData,.badUrl,.badServerResponse, .badRequest, .requestRateExceeded:
						guard let self = self else { fatalError("no view controller object") }
						self.alert.message = error.apiServiceErrors.description
						self.present(self.alert, animated: true, completion: nil)
					}
					switch error.source {
					case .journeys:
						self?.resultJourneysView.configure(data: ResultJourneyViewDataSourse(
							awaitingData: false,
							journeys: nil,
							timeline: nil)
						)
					case .locations:
						self?.searchFieldFrom.setStopLoading()
//					case .stopDepartures:
//						break
					case .customGet:
						break
					}
				}
			}
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
}

extension SearchLocationViewController {
	func hideKeyboardWhenTappedAround() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(SearchLocationViewController.dismissKeyboard))
		tap.cancelsTouchesInView = false
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}


extension SearchLocationViewController : CustomSegmentControlTouchDelegate {
	func segmentedControlDidTouched(didSelectSegmentAtIndex index: Int) {
		self.timeSelectorValueHasChanged(indexTapped: index)
	}
	
	@IBAction func timeSelectorValueHasChanged(indexTapped: Int) {
		switch indexTapped {
		case 0:
			viewModel.updateJourneyTimeValue(date: Date.now)
			self.datePicker.isHidden = true
		case 1:
			self.datePicker.isHidden = false
		default:
			break
		}
	}
}
