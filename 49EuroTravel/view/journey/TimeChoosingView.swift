//
//  TimeChoosingView.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 14.08.23.
//

import UIKit

protocol TimeChooseViewDelegate {
	func timeDidChanged(date: Date)
}

class TimeChoosingView: UIView {
	var delegate : TimeChooseViewDelegate?
	let blur : UIVisualEffectView = {
		let blurEffect = UIBlurEffect(style: .systemChromeMaterialLight)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		return blurEffectView
	}()
	
	let datePicker : UIDatePicker = {
		let datePicker = UIDatePicker()
		datePicker.datePickerMode = .dateAndTime
		datePicker.minuteInterval = 5
		datePicker.timeZone = .current
		datePicker.preferredDatePickerStyle = .inline
		datePicker.tintColor = .gray
		datePicker.setDate(Date.now, animated: true)
		return datePicker
	}()
	
	let doneBtn : UIButton = {
		let btn = UIButton(configuration: .gray())
		btn.configuration?.title = "Done"
		btn.configuration?.baseForegroundColor = .darkGray
		return btn
	}()
	init() {
		super.init(frame: .zero)
		setupUI()
		doneBtn.addTarget(self, action: #selector(datePickerDoneBtnIsPressed), for: .touchUpInside)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func datePickerDoneBtnIsPressed(sender : UIDatePicker){
		delegate?.timeDidChanged(date: datePicker.date)
		self.isHidden = true
	}
	
	func setupUI(){
		self.layer.cornerRadius = Constants.CornerRadius.small
		self.addSubview(blur)
		self.addSubview(datePicker)
		self.addSubview(doneBtn)
		
		blur.translatesAutoresizingMaskIntoConstraints = false
		blur.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		blur.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		blur.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		blur.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		
		datePicker.translatesAutoresizingMaskIntoConstraints = false
		datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		datePicker.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		
		doneBtn.translatesAutoresizingMaskIntoConstraints = false
		doneBtn.topAnchor.constraint(equalTo: self.datePicker.bottomAnchor).isActive = true
		doneBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
		doneBtn.leadingAnchor.constraint(equalTo: self.datePicker.leadingAnchor).isActive = true
		doneBtn.trailingAnchor.constraint(equalTo: self.datePicker.trailingAnchor).isActive = true
	}
}
