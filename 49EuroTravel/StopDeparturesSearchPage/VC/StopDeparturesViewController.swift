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
	var searchFieldFrom = SearchView(placeholder: "from", image: Constants.locationIcon, type: .departure)
	var searchFieldTo = SearchView(placeholder: "to",image: Constants.flipIcon, type: .arrival)
	var timeControl : UISegmentedControl = {
		let str = ["now","06.08.2023 15:03"]
		let view = UISegmentedControl(items: str)
		view.selectedSegmentIndex = 0
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
		setupUI()
		DispatchQueue.main.async {
			self.viewModel.onStateChange = { [ weak self ] state in
				switch state {
				case .onStart:
					self?.searchFieldFrom.configure(
						image: Constants.locationIcon,
						stops: [],
						isNotFound: false
					)
				case .onLoading:
					self?.searchFieldFrom.setLoading()
				case .onNewDataDepartureStop:
					self?.searchFieldFrom.configure(
						image: Constants.locationIcon,
						stops: self?.viewModel.searchLocationDataDeparture ?? [],
						isNotFound: false
					)
				case .onNewDataArrivalStop:
					self?.searchFieldFrom.setStopLoading(view: Constants.locationIcon)
					self?.searchFieldTo.configure(
						image: Constants.flipIcon,
						stops: self?.viewModel.searchLocationDataArrival ?? [],
						isNotFound: false
					)
				case .onNewDataJourney:
					self?.resultJourneysView.configure(data: self?.viewModel.resultJourneysViewDataSourse)
				case .onError(error: let error, _: _):
					self?.searchFieldFrom.setStopLoading(view: Constants.locationIcon)
					
					switch error {
					case .cannotConnectToHost,.cannotDecodeRawData,.cannotDecodeContentData,.badUrl,.badServerResponse, .badRequest, .requestRateExceeded:
						guard let self = self else { fatalError("no view controller object") }
						self.alert.message = error.description
						self.present(self.alert, animated: true, completion: nil)
					}
	//			case .onProfilePage(userModel: let userModel, indexPath: let cellIndexPath, requestGroupId: let requestGroupId):
	//				DispatchQueue.main.async {
	//					let vm = UserProfileViewControllerViewModel(userModel, requestsGgroupIdentifier : requestGroupId, searchVM: self?.viewModel)
	//					let userProfileViewController = UserProfileViewController(viewModel: vm)
	////					self?.navigationController?.pushViewController(userProfileViewController, animated: true)
	//					(self?.collectionView.cellForItem(at: cellIndexPath) as! SearchResultCell).deselectCell()
	//				}
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
