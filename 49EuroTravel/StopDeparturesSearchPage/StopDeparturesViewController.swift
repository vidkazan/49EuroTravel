//
//  ViewController.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 05.05.23.
//

import UIKit

class SearchLocationViewController : UIViewController {
	var viewModel : SearchLocationViewControllerViewModel
	var searchFieldFrom = SearchView(placeholder: "from", image: Constants.locationIcon, type: .departure)
	var searchFieldTo = SearchView(placeholder: "to",image: Constants.flipIcon, type: .arrival)
	var timeControl : UISegmentedControl = {
		let str = ["now","06.08.2023 15:03"]
		let view = UISegmentedControl(items: str)
		view.selectedSegmentIndex = 0
		return view
	}()

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
						break
				case .onError(error: let error, _: _):
					self?.searchFieldFrom.setStopLoading(view: Constants.locationIcon)
					let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
					switch error {
					case .cannotConnectToHost,.cannotDecodeRawData,.cannotDecodeContentData,.badUrl,.badServerResponse, .badRequest, .requestRateExceeded:
						alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
						alert.title = "Error"
						alert.message = error.description
						self?.present(alert, animated: true, completion: nil)
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

extension SearchLocationViewController {
	
	func setupUI(){
		self.navigationItem.title = "Chew-chew"
		self.view.backgroundColor = UIColor.white
		self.searchFieldTo.backgroundColor = Constants.Gray49
		self.searchFieldFrom.backgroundColor = Constants.Gray49
		
		view.addSubview(timeControl)
		view.addSubview(searchFieldTo)
		view.addSubview(searchFieldFrom)
		
		
		searchFieldFrom.translatesAutoresizingMaskIntoConstraints = false
		searchFieldFrom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		searchFieldFrom.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
		searchFieldFrom.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
		
		searchFieldTo.translatesAutoresizingMaskIntoConstraints = false
		searchFieldTo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 43).isActive = true
		searchFieldTo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
		searchFieldTo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
		
		timeControl.translatesAutoresizingMaskIntoConstraints = false
		timeControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 85).isActive = true
		timeControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
		timeControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
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
