//
//  DepartureCell.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 05.05.23.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
	static let identifier = "SearchResultCell"
	
	public func configure(with data: Stop) {
		self.layer.cornerRadius = Constants.CornerRadius.standart
		self.name.text = "\(data.name ?? "_")"
		self.name.textColor = UIColor.black
	}
	
	private let name : UILabel = {
		let name = UILabel()
		name.textColor = UIColor.black
		name.font = UIFont.systemFont(ofSize: 17, weight: .regular)
		name.textAlignment = .left
		return name
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(name)
				
		name.lineBreakMode = .byWordWrapping
		name.numberOfLines = 0
		name.textAlignment = .left
		name.translatesAutoresizingMaskIntoConstraints = false
		name.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		name.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
		name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	override func prepareForReuse() {
		super.prepareForReuse()
		self.name.text = nil
	}
}
