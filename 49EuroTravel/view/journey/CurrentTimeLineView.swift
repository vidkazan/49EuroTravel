//
//  CurrentTimeLineVIew.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 09.08.23.
//

import UIKit

class CurrentTimeLineView: UIView {
	let label : UILabel = {
		let l = UILabel()
		l.text = "15:03"
		l.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
		return l
	}()
	let line : UIView = {
		let v = UIView()
		v.backgroundColor = .red
		v.layer.cornerRadius = 2
		return v
	}()
	let lineRight : UIView = {
		let v = UIView()
		v.backgroundColor = .red
		return v
	}()
	init() {
		super.init(frame: .zero)
		setupUI()
	}
	
	func setupUI(){
		self.addSubview(line)
		self.addSubview(label)
		self.addSubview(lineRight)
		
		
		line.translatesAutoresizingMaskIntoConstraints = false
		line.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		line.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -(UIScreen.main.bounds.width/9) ).isActive = true
		line.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		line.heightAnchor.constraint(equalToConstant: 2).isActive = true
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.leadingAnchor.constraint(equalTo: line.trailingAnchor,constant: 3).isActive = true
		label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		
		lineRight.translatesAutoresizingMaskIntoConstraints = false
		lineRight.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 3).isActive = true
		lineRight.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		lineRight.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		lineRight.heightAnchor.constraint(equalToConstant: 2).isActive = true
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
