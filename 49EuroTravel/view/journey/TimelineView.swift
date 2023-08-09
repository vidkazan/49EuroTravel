//
//  TimelineView.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import UIKit

class TimeLabelView: UIView {
	let label : UILabel = {
		let l = UILabel()
		l.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
		l.textColor = .darkGray
		return l
	}()
	let line : UIView = {
		let v = UIView()
		v.backgroundColor = .darkGray
		v.layer.cornerRadius = 1
		return v
	}()
	let lineRight : UIView = {
		let v = UIView()
		v.backgroundColor = .darkGray
		v.layer.cornerRadius = 1
		return v
	}()
	init(text : String) {
		super.init(frame: .zero)
		self.label.text = text
		setupUI()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupUI(){
		self.addSubview(line)
		self.addSubview(lineRight)
		self.addSubview(label)
		
		
		line.translatesAutoresizingMaskIntoConstraints = false
		line.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		line.trailingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5 ).isActive = true
		line.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		line.heightAnchor.constraint(equalToConstant: 1).isActive = true
		
		lineRight.translatesAutoresizingMaskIntoConstraints = false
		lineRight.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
		lineRight.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		lineRight.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		lineRight.heightAnchor.constraint(equalToConstant: 1).isActive = true
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		
	}
}

class TimelineView: UIView {
	var workingViews : [UIView] = []
	init() {
		super.init(frame: .zero)
		self.backgroundColor = .systemGray5
		self.layer.cornerRadius = Constants.CornerRadius.tiny
	}
	func configure(data: TimelineViewDataSourse?){
		guard let data = data else {
			for view in workingViews {
				view.removeFromSuperview()
			}
			return
		}
		for labelData in data.timeLabels {
			let label = TimeLabelView(text: labelData.text)
			workingViews.append(label)
			self.addSubview(label)
			label.translatesAutoresizingMaskIntoConstraints = false
			label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
			label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
			label.centerYAnchor.constraint(equalTo: self.topAnchor, constant: self.bounds.height * labelData.textCenterYposition).isActive = true
		}
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
