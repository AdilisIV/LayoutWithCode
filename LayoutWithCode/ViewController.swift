//
//  ViewController.swift
//  LayoutWithCode
//
//  Created by user on 5/31/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Views
    private var dialogView: UIView!
    private var titleLabel: UILabel!
    open var pickerView: UIDatePicker!
    private var cancelButton: UIButton!
    private var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    
    func setupView() {
        // dialogView
        dialogView = UIView()
        dialogView.backgroundColor = .white
        view.addSubview(dialogView)
        dialogView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dialogView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(260)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dialogView]))
        
        
        let pickerViewWrapper = UIView()
        pickerViewWrapper.backgroundColor = .blue
        dialogView.addSubview(pickerViewWrapper)
        pickerViewWrapper.translatesAutoresizingMaskIntoConstraints = false
        dialogView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": pickerViewWrapper]))
        dialogView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(200)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": pickerViewWrapper]))
        
        let topView = UIView()
        topView.backgroundColor = .black
        dialogView.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        dialogView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": topView]))
        dialogView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0][v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": topView, "v1": pickerViewWrapper]))
        
        let titleLabel = UILabel()
        titleLabel.text = "Выберите дату"
        titleLabel.textColor = .white
        topView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        topView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: topView, attribute: .centerX, multiplier: 1, constant: 0))
        topView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: topView, attribute: .centerY, multiplier: 1, constant: 0))
        
        let cancelButton = UIButton()
        cancelButton.setTitle("Отмена", for: .normal)
        topView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        topView.addConstraint(NSLayoutConstraint(item: cancelButton, attribute: .centerY, relatedBy: .equal, toItem: topView, attribute: .centerY, multiplier: 1, constant: 0))
        topView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0][v1]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": cancelButton, "v1": titleLabel]))
        
        // V: верх|  |низ
    }


}

