//
//  TimePickerView.swift
//  UKClient
//
//  Created by Ричард Брэндсон on 4/25/18.
//  Copyright © 2018 Ричард Брэндсон. All rights reserved.
//

import UIKit

enum TimePickerFieldMode: Int {
    case date = 1
    case timeFrom = 2
    case timeTo = 3
}

private extension Selector {
    static let done = #selector(TimePickerView.doneButtonTapped)
    static let cancel = #selector(TimePickerView.cancelButtonTapped)
}

class TimePickerView: UIView {
    
    public typealias TimePickerCallback = ( Date? ) -> Void
    
    // MARK: - Constants
    private let kDefaultButtonHeight: CGFloat = 50
    private let kDefaultButtonSpacerHeight: CGFloat = 1
    
    // MARK: - Views
    private var dialogView: UIView!
    private var titleLabel: UILabel!
    open var pickerView: UIDatePicker!
    private var cancelButton: UIButton!
    private var doneButton: UIButton!
    
    // MARK: - Variables
    
    private var callback: TimePickerCallback?
    var mode: TimePickerFieldMode = .date {
        didSet {
            switch mode {
            case .date:
                self.pickerView.datePickerMode = .date
                self.titleLabel.text = "Выберите дату"
            default:
                self.pickerView.datePickerMode = .time
                self.pickerView.minuteInterval = 10
                self.titleLabel.text = "Выберите время"
            }
        }
    }
    
    
    // MARK: - Init
    
    public init() {
        let size = UIScreen.main.bounds.size
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Actions
    
    @objc func doneButtonTapped(sender: UIButton!) {
        self.callback?(pickerView.date)
        dismiss()
    }
    
    @objc func cancelButtonTapped(sender: UIButton!) {
        dismiss()
    }
    
    
    // MARK: - Functions
    
    func setupView() {
        self.dialogView = createPickerWrapper()
        
        self.dialogView.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 260)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        self.addSubview(self.dialogView)
    }
    
    func show(view: UIView, success: @escaping (Bool) -> ()? = { _ in print("TimePickerView show.") }, doneCallback: @escaping TimePickerCallback) {
        
//        let tapOverlayRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        
        self.callback = doneCallback
        
        guard let appDelegate = UIApplication.shared.delegate else { fatalError() }
        guard let window = appDelegate.window else { fatalError() }
        
        window?.addSubview(self)
//        window?.bringSubview(toFront: self)
//        window?.endEditing(true)
        
        UIView.animate(withDuration: 0.5) {
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            self.dialogView.frame.origin.y = self.frame.height-self.dialogView.frame.height
        }
        
    }

    
    @objc func gestureDismiss() {
        print("gestureDismiss")
        let window = UIApplication.shared.keyWindow
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            self.pickerView.frame.origin.y = (window?.frame.height)!
        }) { (_) in
            for v in self.subviews {
                v.removeFromSuperview()
            }
            self.removeFromSuperview()
            self.setupView()
        }
    }
    
    @objc func dismiss() {
        let window = UIApplication.shared.keyWindow
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            self.pickerView.frame.origin.y = (window?.frame.height)!
        }) { (_) in
            for v in self.subviews {
                v.removeFromSuperview()
            }
            self.removeFromSuperview()
            self.setupView()
        }
    }
    
    private func createPickerWrapper() -> UIView {
        let screenSize = UIScreen.main.bounds.size
        let dialogSize = CGSize(width: screenSize.width, height: 260)
        
        let dialogView = UIView(frame: CGRect(x: 0, y: 0, width: dialogSize.width, height: dialogSize.height))
        
//
        let pickerWrapper = UIView(frame: CGRect(x: 0, y: 0, width: dialogSize.width, height: 200))
        pickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: dialogSize.width, height: 200))
        pickerView.backgroundColor = UIColor.blue
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.datePickerMode = .date
        pickerView.date = Date()
        pickerWrapper.addSubview(pickerView)
        addHeightConstraint(pickerWrapper, height: 200)
        addBottomConstraint(pickerView, toView: pickerWrapper)
        addTrailingConstraint(pickerView, toView: pickerWrapper)
        addLeadingConstraint(pickerView, toView: pickerWrapper)
        addTopConstraint(pickerView, toView: pickerWrapper)
        
        dialogView.addSubview(pickerWrapper)
        addBottomConstraint(pickerWrapper, toView: dialogView)
        addTrailingConstraint(pickerWrapper, toView: dialogView)
        addLeadingConstraint(pickerWrapper, toView: dialogView)
        
        
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: dialogSize.width, height: 52))
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = UIColor.white
        dialogView.addSubview(topView)
        addHeightConstraint(topView, height: 52)
        addTrailingConstraint(topView, toView: dialogView)
        addLeadingConstraint(topView, toView: dialogView)
        addTopConstraint(topView, toView: dialogView)
        addBottomConstraint(topView, toView: pickerWrapper, constant: 8)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        titleLabel.text = "Выберите дату"
        topView.addSubview(titleLabel)
        addXConstraint(titleLabel, toView: topView)
        addYConstraint(titleLabel, toView: topView)
        
        cancelButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.setTitleColor(UIColor.RGB(red: 5, green: 122, blue: 255), for: .normal)
        cancelButton.addTarget(self, action: .cancel, for: .touchUpInside)
        topView.addSubview(cancelButton)
        addYConstraint(cancelButton, toView: topView)
        addTrailingConstraint(cancelButton, toView: topView, constant: 8)
        addLeadingConstraint(cancelButton, toView: titleLabel, constant: 8)
        
        doneButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Готово", for: .normal)
        doneButton.setTitleColor(UIColor.RGB(red: 5, green: 122, blue: 255), for: .normal)
        doneButton.addTarget(self, action: .done, for: .touchUpInside)
        topView.addSubview(doneButton)
        addYConstraint(doneButton, toView: topView)
        addLeadingConstraint(doneButton, toView: titleLabel, constant: 8)
        addTrailingConstraint(doneButton, toView: topView, constant: 8)
        
        dialogView.backgroundColor = UIColor.white
        return dialogView
    }
    
    func setupView(textFieldTag: Int, appeal: Appeal?) {
        switch textFieldTag {
        case 1:
            self.mode = .date
            if appeal != nil {
                if appeal?.convenientDate != "" {
                    self.pickerView.date = dateWithOutTimeFrom(string: appeal?.convenientDate)!
                } else { self.pickerView.date = Date() }
            } else { self.pickerView.date = Date() }
        case 2:
            self.mode = .timeFrom
            if appeal != nil {
                if appeal?.convenientTimeFrom != "" {
                    self.pickerView.date = roundTimeFrom(string: (appeal?.convenientTimeFrom)!)
                } else { self.pickerView.date = roundTimeFrom(time: Date()) }
            } else { self.pickerView.date = roundTimeFrom(time: Date()) }
        case 3:
            self.mode = .timeTo
            if appeal != nil {
                if appeal?.convenientTimeTo != "" {
                    self.pickerView.date = timeFrom(string: appeal?.convenientTimeTo)!
                } else { self.pickerView.date = Date() }
            } else { self.pickerView.date = Date() }
        default:
            self.mode = .date
            self.pickerView.date = Date()
        }
    }

}

extension TimePickerView {
    
    private func loadPickerFormFromXib() -> TimePickerView {
        let view: TimePickerView = Bundle.main.loadNibNamed("TimePickerView", owner: self, options: nil)?.first as! TimePickerView
        return view
    }
    
}
