//
//  SearchAndResultsView.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 07.08.23.
//

import UIKit

enum LocationDirectionType{
	case departure
	case arrival
}

protocol SearchViewDelegate {
	func textFieldDidChange(text: String, type: LocationDirectionType)
	func stopCellDidPressed(stop : Stop, type: LocationDirectionType)
}

class SearchAndResultsView: UIView {
	var type : LocationDirectionType
	var stops : [Stop] = []
	var delegate: SearchViewDelegate?
	let resultsView : UIStackView = {
		let view = UIStackView()
		view.axis = .vertical
		view.distribution = .fillEqually
		view.spacing = 15
		return view
	}()
	let name : UITextField = {
		let name = UITextField()
		name.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
		name.rightViewMode = .always
		name.font = UIFont.systemFont(ofSize: 17, weight: .regular)
		return name
	}()
	
	@objc private func textFieldDidChange(_ textField: UITextField) {
		delegate?.textFieldDidChange(text: textField.text ?? "", type: self.type)
	}
	
	@objc private func viewTapped(_ sender : UITapGestureRecognizer) {
		guard let tappedView = sender.view else { return }
		guard let indexOfTappedView = resultsView.arrangedSubviews.firstIndex(of: tappedView) else { return }
		let tappedStop = stops[indexOfTappedView]
		delegate?.stopCellDidPressed(stop : tappedStop, type: self.type)
		self.name.text = tappedStop.name
		self.resultsView.removeArrangedSubviews()
		self.name.endEditing(true)
	}
	
	init(placeholder : String?, image : UIView?, type : LocationDirectionType) {
		self.type = type
		super.init(frame: .zero)
		self.layer.cornerRadius = Constants.CornerRadius.small
		self.backgroundColor = .systemGray6
		self.name.rightView = image
		if let image = image {
			image.tintColor = .darkGray
		}
		name.placeholder = placeholder
		setupStackView()
		setupUI()
	}
	
	func setupStackView(){
		resultsView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
		resultsView.isLayoutMarginsRelativeArrangement = true
	}
	
	func updateResultView(stops : [Stop], isNotFound : Bool){
		resultsView.removeArrangedSubviews()
		switch isNotFound {
			case true:
				resultsView.addArrangedSubview(createLabelByText(text: "No stops found:(", alert : true))
			case false:
				stops.forEach { Stop in
					resultsView.addArrangedSubview(createLabelByText(text: Stop.name, alert : false))
					resultsView.arrangedSubviews.last?.addGestureRecognizer(
						UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
					)
				}
		}
	}
	
	func configure(image: UIView?, stops : [Stop], isNotFound : Bool) {
		self.stops = stops
		updateResultView(stops: stops,isNotFound: isNotFound)
		if let image = image {
			self.name.rightView = image
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupUI(){
		addSubview(name)
		addSubview(resultsView)
		
		name.translatesAutoresizingMaskIntoConstraints = false
		name.topAnchor.constraint(equalTo: self.topAnchor, constant: 7).isActive = true
		name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
		name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
		
		resultsView.translatesAutoresizingMaskIntoConstraints = false
		resultsView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
		resultsView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5).isActive = true
		resultsView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		resultsView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
	}
}

extension SearchAndResultsView {
	func setLoading() {
		let activityIndicator = UIActivityIndicatorView(style: .medium)
		activityIndicator.color = .gray
		activityIndicator.startAnimating()
		self.name.rightView = activityIndicator
	}
	func setStopLoading(view : UIView?) {
		self.name.rightView = view
	}
}
