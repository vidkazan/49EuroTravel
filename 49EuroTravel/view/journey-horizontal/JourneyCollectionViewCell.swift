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
	let legs = HorizontalJourneyView()
	let badges = JourneyCellBadgesView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		header.layer.cornerRadius = Constants.CornerRadius.small
		badges.layer.cornerRadius = Constants.CornerRadius.small
		
		addSubview(header)
		addSubview(badges)
		addSubview(legs)
		
//		header.backgroundColor = UIColor(red: 1, green: 0.98, blue: 0.88, alpha: 1)
//		header.backgroundColor = UIColor(red: 1, green: 0.9, blue: 0.5, alpha: 1)
		header.backgroundColor = .systemGray3
		
		header.translatesAutoresizingMaskIntoConstraints = false
		header.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		header.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		header.heightAnchor.constraint(equalToConstant: 35).isActive = true
		header.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		
		badges.translatesAutoresizingMaskIntoConstraints = false
		badges.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
		badges.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		badges.heightAnchor.constraint(equalToConstant: 30).isActive = true
		badges.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		
		legs.translatesAutoresizingMaskIntoConstraints = false
		legs.topAnchor.constraint(equalTo: header.bottomAnchor,constant: 5).isActive = true
		legs.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
		legs.bottomAnchor.constraint(equalTo: badges.topAnchor, constant: -5).isActive = true
		legs.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
	}
	
	
	public func configure(with data: JourneyCollectionViewDataSourse?) {
		guard let data = data else { return }
		self.legs.configure(data: data)
		self.header.configure(data: data)
		self.badges.configure(data: [.dticket])
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
