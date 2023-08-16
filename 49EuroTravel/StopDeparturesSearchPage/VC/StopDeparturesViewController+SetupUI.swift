//
//  S.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import UIKit

extension SearchLocationViewController {
	func setupColors(){
		self.view.backgroundColor = .white
		self.timeControl.backgroundColor = .white
		self.searchFieldTo.backgroundColor = Constants.Gray49
		self.searchFieldFrom.backgroundColor = Constants.Gray49
		self.resultJourneysView.backgroundColor = .white
	}
}

extension SearchLocationViewController {
	func setupUI(){
		self.navigationItem.title = "Chew-chew"
		
		view.addSubview(resultScrollView)
		view.addSubview(timeControl)
		view.addSubview(searchFieldTo)
		view.addSubview(searchFieldFrom)
		view.addSubview(datePicker)
		
		resultScrollView.addSubview(resultJourneysView)
		resultJourneysView.translatesAutoresizingMaskIntoConstraints = false
		resultJourneysView.topAnchor.constraint(equalTo: resultScrollView.topAnchor).isActive = true
		resultJourneysView.leadingAnchor.constraint(equalTo: resultScrollView.leadingAnchor).isActive = true
		resultJourneysView.widthAnchor.constraint(equalTo: resultScrollView.widthAnchor).isActive = true
		resultJourneysView.heightAnchor.constraint(equalTo: resultScrollView.heightAnchor,multiplier: 1).isActive = true
		
		datePicker.translatesAutoresizingMaskIntoConstraints = false
		datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		datePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		
		searchFieldFrom.translatesAutoresizingMaskIntoConstraints = false
		searchFieldFrom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		searchFieldFrom.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
		searchFieldFrom.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
		
		searchFieldTo.translatesAutoresizingMaskIntoConstraints = false
		searchFieldTo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 38).isActive = true
		searchFieldTo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
		searchFieldTo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
		
		timeControl.translatesAutoresizingMaskIntoConstraints = false
		timeControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 76).isActive = true
		timeControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
		timeControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
		
		resultScrollView.translatesAutoresizingMaskIntoConstraints = false
		resultScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 115).isActive = true
		resultScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
		resultScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
		resultScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
	}
}
