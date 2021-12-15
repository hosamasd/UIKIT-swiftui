//
//  UIkitVC.swift
//  UIKIT+swiftui
//
//  Created by hosam on 15/12/2021.
//

import SwiftUI

extension UIAlertController {
    
    /// - Parameters:
    ///   - title: action title
    ///   - style: action style (default is UIAlertActionStyle.default)
    ///   - isEnabled: isEnabled status for action (default is true)
    ///   - handler: optional action handler to be called when button is tapped (default is nil)
    func addAction(image: UIImage? = nil, title: String, color: UIColor? = nil, style: UIAlertAction.Style = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)? = nil) {
        //let isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
        //let action = UIAlertAction(title: title, style: isPad && style == .cancel ? .default : style, handler: handler)
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        
        // button image
        if let image = image {
            action.setValue(image, forKey: "image")
        }
        
        // button title color
        if let color = color {
            action.setValue(color, forKey: "titleTextColor")
        }
        
        addAction(action)
    }
    /// Create new alert view controller.
    ///
    /// - Parameters:
    ///   - style: alert controller's style.
    ///   - title: alert controller's title.
    ///   - message: alert controller's message (default is nil).
    ///   - defaultActionButtonTitle: default action button title (default is "OK")
    ///   - tintColor: alert controller's tint color (default is nil)
    convenience init(style: UIAlertController.Style, source: UIView? = nil, title: String? = nil, message: String? = nil, tintColor: UIColor? = nil) {
        self.init(title: title, message: message, preferredStyle: style)
        
        // TODO: for iPad or other views
        let isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
        let root = UIApplication.shared.windows.first?.rootViewController?.view
        
        //self.responds(to: #selector(getter: popoverPresentationController))
        if let source = source {
            print("----- source")
            popoverPresentationController?.sourceView = source
            popoverPresentationController?.sourceRect = source.bounds
        } else if isPad, let source = root, style == .actionSheet {
            print("----- is pad")
            popoverPresentationController?.sourceView = source
            popoverPresentationController?.sourceRect = CGRect(x: source.bounds.midX, y: source.bounds.midY, width: 0, height: 0)
            //popoverPresentationController?.permittedArrowDirections = .down
            popoverPresentationController?.permittedArrowDirections = .init(rawValue: 0)
        }
        
        if let color = tintColor {
            self.view.tintColor = color
        }
    }

    
    /// Set alert's content viewController
    ///
    /// - Parameters:
    ///   - vc: ViewController
    ///   - height: height of content viewController
    func set(vc: UIViewController?, width: CGFloat? = nil, height: CGFloat? = nil) {
        guard let vc = vc else { return }
        setValue(vc, forKey: "contentViewController")
        if let height = height {
            vc.preferredContentSize.height = height
            preferredContentSize.height = height
        }
    }
    
    func addDatePicker(mode: UIDatePicker.Mode, date: Date?, minimumDate: Date? = nil, maximumDate: Date? = nil, action: DatePickerViewController.Action?)
    {
     
        
        var  local: NSLocale = NSLocale(localeIdentifier: "en") as NSLocale
             
                   local = NSLocale(localeIdentifier: "en") as NSLocale
        
        let datePicker = DatePickerViewController(mode: mode, date: date, minimumDate: minimumDate, maximumDate: maximumDate, action: action, local: local)
    
        set(vc: datePicker, height: 217)
    }
}

final class DatePickerViewController: UIViewController {
    
    public typealias Action = (Date) -> Void
    
    fileprivate var action: Action?
    
    fileprivate lazy var datePicker: UIDatePicker = { [unowned self] in
        $0.addTarget(self, action: #selector(DatePickerViewController.actionForDatePicker), for: .valueChanged)
        return $0
    }(UIDatePicker())
    
    required init(mode: UIDatePicker.Mode, date: Date? = nil, minimumDate: Date? = nil, maximumDate: Date? = nil, action: Action? , local : NSLocale) {
        super.init(nibName: nil, bundle: nil)
        datePicker.datePickerMode = mode
        datePicker.date = date ?? Date()
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumDate
        datePicker.locale = local as Locale

        self.action = action
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("has deinitialized")
    }
    
    override func loadView() {
        view = datePicker
    }
    
    @objc func actionForDatePicker() {
        action?(datePicker.date)
    }
    
    public func setDate(_ date: Date) {
        datePicker.setDate(date, animated: true)
    }
}

extension UIView {
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
}

extension Date {
    func toTimeOnlyFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: self)
    }
    func toUrlTime() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "M/dd/yyyy h:mm:ss a"
        return dateFormatter.string(from: self)
    }
    
    
}


class UIkitVC: UIViewController {

    lazy var mainView = UIHostingController(rootView: UIkitScene(action: showMenuVC, timeAction: showTransactionTimePicker))//, timeAction: showTransactionTimePicker ))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden=true
//        navigationController?.navigationItem.title = "Reports Menu"
        
        view.addSubview(mainView.view)
        mainView.view.fillSuperview(padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
 
    deinit {
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }
    
    func showMenuVC()  {
        dismiss(animated: true, completion: nil)
    }
    
    func showTransactionTimePicker() {//->(String,String) {
        var s = ""
        var b = ""
        
        let defaults = UserDefaults.standard

       
        
        
        
        let alert = UIAlertController(style: .actionSheet, title: NSLocalizedString("Select Time", comment: ""))
        alert.addDatePicker(mode: .time, date: Date(), minimumDate: nil, maximumDate: nil) {
            date in
             s = date.toTimeOnlyFormat()
             b =  date.toUrlTime()
            
            defaults.set(date.toTimeOnlyFormat(), forKey: "ss")
            defaults.set(date.toUrlTime(), forKey: "s")
         
            let userInfo:[String:String] = [
                "key":date.toUrlTime()
            ]
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "sss") ,
                                                           object: nil,
                                                           userInfo: userInfo))
            
//            self.transactionTimeLabel.text = date.toTimeOnlyFormat()
//            self.presenter.setTime(time: date.toUrlTime())
        }
        
        alert.addAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: { _ in
            
            defaults.set(Date().toTimeOnlyFormat(), forKey: "ww")
            defaults.set(Date().toUrlTime(), forKey: "w")
                            
           
            
            
                          
        })
        
        self.present(alert, animated: true, completion: nil)
        defaults.synchronize()
        
    }
    
}
struct InfoVSCRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // leave this empty
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return UINavigationController(rootViewController: UIkitVC())
    }
}

struct InfoSVCPreview: PreviewProvider {
    static var previews: some View {
        InfoVSCRepresentable()
    }
}

