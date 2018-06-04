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
        
        self.dialogView = setupView()
        
        view.addSubview(self.dialogView)
    }
    
    
    func setupView() -> UIView {
        // dialogView
        let screenSize = UIScreen.main.bounds.size
        let dialogSize = CGSize(width: screenSize.width, height: 260)
        
        let dialogView = UIView(frame: CGRect(x: 0, y: 0, width: dialogSize.width, height: dialogSize.height))
        dialogView.backgroundColor = .white
        view.addSubview(dialogView)
        dialogView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dialogView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(260)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dialogView]))
        
        
        let pickerViewWrapper = UIView()
        pickerViewWrapper.backgroundColor = .white
        dialogView.addSubview(pickerViewWrapper)
        pickerViewWrapper.translatesAutoresizingMaskIntoConstraints = false
        dialogView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": pickerViewWrapper]))
        dialogView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(200)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": pickerViewWrapper]))
        
        let topView = UIView()
        topView.backgroundColor = .white
        dialogView.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        dialogView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": topView]))
        dialogView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0][v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": topView, "v1": pickerViewWrapper]))
        
        titleLabel = UILabel()
        titleLabel.text = "Выберите дату"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        topView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        topView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: topView, attribute: .centerX, multiplier: 1, constant: 0))
        topView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: topView, attribute: .centerY, multiplier: 1, constant: 0))
        
        cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Отмена", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        cancelButton.setTitleColor(view.tintColor, for: .normal)
        cancelButton.contentHorizontalAlignment = .left
        topView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        topView.addConstraint(NSLayoutConstraint(item: cancelButton, attribute: .centerY, relatedBy: .equal, toItem: topView, attribute: .centerY, multiplier: 1, constant: 0))
        topView.addConstraintsWithFormat(format: "H:|-8-[v0]-8-[v1]", views: cancelButton, titleLabel)
        
        doneButton = UIButton(type: .system)
        doneButton.setTitle("Готово", for: .normal)
        doneButton.setTitleColor(view.tintColor, for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        doneButton.contentHorizontalAlignment = .right
        topView.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        topView.addConstraint(NSLayoutConstraint(item: doneButton, attribute: .centerY, relatedBy: .equal, toItem: topView, attribute: .centerY, multiplier: 1, constant: 0))
        topView.addConstraintsWithFormat(format: "H:[v0]-8-[v1]-8-|", views: titleLabel, doneButton)
        
        pickerView = UIDatePicker()
        pickerView.datePickerMode = .date
        pickerView.date = Date()
        pickerViewWrapper.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerViewWrapper.addConstraintsWithFormat(format: "V:|[v0]|", views: pickerView)
        pickerViewWrapper.addConstraintsWithFormat(format: "H:|[v0]|", views: pickerView)

        return dialogView
        
        // V: верх|  |низ
    }


}

