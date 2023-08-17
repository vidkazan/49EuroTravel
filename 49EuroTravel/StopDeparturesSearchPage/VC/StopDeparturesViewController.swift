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
		view.layer.cornerRadius = Constants.CornerRadius.standart
		let font = UIFont.systemFont(ofSize: 16)
		view.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
		view.selectedSegmentIndex = 0

		return view
	}()
//	var resultScrollView : UIScrollView = {
//		let view = UIScrollView()
//		return view
//	}()
//	var resultJourneysView = ResultJourneysView()
	
	var journeyCollectionView : UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.register(JourneyCollectionViewCell.self, forCellWithReuseIdentifier: JourneyCollectionViewCell.identifier)
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
		self.datePicker.delegate = self
		self.timeControl.customDelegate = self

		
		setupCollectionView()
		setupUI()
		setupColors()
		DispatchQueue.main.async {
			self.viewModel.onStateChange = { [ weak self ] state in
				switch state {
				case .onStart:
					break
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
//					self?.resultJourneysView.configure(data: self?.viewModel.resultJourneysViewDataSourse)
					self?.journeyCollectionView.reloadData()
					break
				case .onError(error: let error, _: _):
					switch error.apiServiceErrors {
					case .cannotConnectToHost,.cannotDecodeRawData,.cannotDecodeContentData,.badUrl,.badServerResponse, .badRequest, .requestRateExceeded:
						guard let self = self else { fatalError("no view controller object") }
						self.alert.message = error.apiServiceErrors.description
						self.present(self.alert, animated: true, completion: nil)
					}
					switch error.source {
					case .journeys:
						self?.journeyCollectionView.reloadData()
//						self?.resultJourneysView.configure(data: ResultJourneyViewDataSourse(
//							awaitingData: false,
//							journeys: nil,
//							timeline: nil)
//						)
					case .locations:
						self?.searchFieldFrom.setStopLoading()
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

extension SearchLocationViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate {
	func collectionView(_ : UICollectionView, numberOfItemsInSection: Int) -> Int {
		switch self.viewModel.state {
		case .onNewDataJourney:
			return self.viewModel.journeysData?.journeys!.count ?? 1
		case .onError,.onNewDataArrivalStop,.onNewDataDepartureStop,.onStart:
			return 0
		}
	}
	func collectionView(_ collectionView : UICollectionView, cellForItemAt indexPath: IndexPath) ->  UICollectionViewCell {
		if viewModel.resultJourneysCollectionViewDataSourse != nil,
		   let journeys = viewModel.resultJourneysCollectionViewDataSourse?.journeys,
		   viewModel.journeysData!.journeys!.count > 0 {
			let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: JourneyCollectionViewCell.identifier,
				for: indexPath
			) as! JourneyCollectionViewCell
			
			cell.layer.cornerRadius = Constants.CornerRadius.standart
			cell.backgroundColor = .white
			cell.addShadow()
			if !journeys.isEmpty, viewModel.resultJourneysCollectionViewDataSourse?.awaitingData != true {
				cell.configure(with: journeys[indexPath.row])
			} else {
				cell.configure(with: nil)
			}
			return cell
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JourneyCollectionViewCell.identifier, for: indexPath) as! JourneyCollectionViewCell
			cell.configure(with: nil)
			return cell
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: collectionView.frame.width - 10, height: 120)
	}
	
//	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//		guard let cell = self.collectionView.cellForItem(at: indexPath) as? SearchResultCell else {
//			return
//		}
//		let dataUser = viewModel.searchUsersData[indexPath.row]
//		prints("tap ", dataUser.login!)
//		cell.selectCell()
//		viewModel.fetchUser(userId: dataUser.id, requestsGgroupIdentifier: String(Date.now.timeIntervalSince1970), cellIndexPath: indexPath)
//	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		cell.alpha = 0
		cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
		
		UIView.animate(withDuration: 0.25) {
			cell.alpha = 1
			cell.transform = .identity
		}
	}
	func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		cell.alpha = 1
		cell.transform = .identity
		
		UIView.animate(withDuration: 0.25) {
			cell.alpha = 0
			cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
		}
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
