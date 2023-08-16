//
//  JourneyCollectionViewCell.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 16.08.23.
//

import UIKit

class JourneyCollectionViewCell: UICollectionViewCell {
	static let identifier = "JourneyCollectionViewCell"
	let header = JourneyCellHeaderView()
	let journey = JourneyCellLegsView()
	let badges = JourneyCellBadgesView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		header.layer.cornerRadius = Constants.CornerRadius.standart
		badges.layer.cornerRadius = Constants.CornerRadius.standart
		
		addSubview(header)
		addSubview(badges)
		addSubview(journey)
		
		header.backgroundColor = UIColor(red: 1, green: 0.98, blue: 0.88, alpha: 1)
		
		header.translatesAutoresizingMaskIntoConstraints = false
		header.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		header.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		header.heightAnchor.constraint(equalToConstant: 35).isActive = true
		header.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		
		badges.translatesAutoresizingMaskIntoConstraints = false
		badges.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		badges.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		badges.heightAnchor.constraint(equalToConstant: 25).isActive = true
		badges.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		
		journey.translatesAutoresizingMaskIntoConstraints = false
		journey.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
		journey.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
		journey.bottomAnchor.constraint(equalTo: badges.topAnchor).isActive = true
		journey.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
	}
	
	
	public func configure(with data: JourneyCollectionViewDataSourse?) {
		guard let data = data else { return }
		self.header.configure(data: data)
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
