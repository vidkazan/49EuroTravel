//
//  PrintUIView.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 17.08.23.
//

import UIKit

class PrintUIView: UIView {
	override func updateConstraints() {
		prints("updateConstraints",self.description)
		super.updateConstraints()
	}
	
	override func layoutSubviews() {
		prints("layoutSubviews",self.description)
		super.layoutSubviews()
	}
}
