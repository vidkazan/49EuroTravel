//
//  ChangeView.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import UIKit

class ChangeView: UIView {
	init() {
		super.init(frame: .zero)
		self.backgroundColor = UIColor.CompanionColors.red
//		self.layer.cornerRadius = Constants.CornerRadius.tiny
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
