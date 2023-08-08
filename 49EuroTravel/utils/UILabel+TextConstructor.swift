//
//  UILabel+TextConstructor.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 07.08.23.
//

import UIKit

func createLabelByText(text : String?, alert : Bool) -> UIView {
	let view : UIView = {
		let view = UIView()
		view.isUserInteractionEnabled = true
		return view
	}()
	
	let label : UILabel =  {
		let label = UILabel()
		label.text = text
		label.numberOfLines = 1
		switch alert {
			case true:
				label.textAlignment = .center
				label.textColor = .systemGray3
			case false:
				break
		}
		return label
	}()
	
	view.addSubview(label)
	label.translatesAutoresizingMaskIntoConstraints = false
	label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
	label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
	label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
	label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	return view
}
