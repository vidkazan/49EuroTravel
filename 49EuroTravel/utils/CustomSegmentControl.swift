//
//  CustomSegmentControl.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 14.08.23.
//

import UIKit

protocol CustomSegmentControlTouchDelegate {
	func segmentedControlDidTouched(didSelectSegmentAtIndex index: Int)
}

class CustomSegmentControl: UISegmentedControl {
	var customDelegate: CustomSegmentControlTouchDelegate?
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		super.touchesEnded(touches, with: event)
		
		if let touch = touches.first {
			let touchLocation = touch.location(in: self)
			let segmentWidth = self.bounds.width / CGFloat(self.numberOfSegments)
			let tappedSegmentIndex = Int(touchLocation.x / segmentWidth)
			
			
			// You can perform any actions you want based on the tapped segment index
			// For example, update UI, trigger functions, etc.
			customDelegate?.segmentedControlDidTouched(didSelectSegmentAtIndex: tappedSegmentIndex)
		}
	}
}
