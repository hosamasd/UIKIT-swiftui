//
//  ViewController.swift
//  UIKIT+swiftui
//
//  Created by hosam on 15/12/2021.
//

import UIKit
import SwiftUI

extension UIButton {
    convenience public init(title: String, titleColor: UIColor, font: UIFont = .systemFont(ofSize: 14), backgroundColor: UIColor = .clear, target: Any? = nil, action: Selector? = nil) {
        self.init(type: .system)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        
        self.backgroundColor = backgroundColor
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
    
}

class ViewController: UIViewController {

    lazy var btn = UIButton(title: "go to next Swiftui View", titleColor: .white, font: .boldSystemFont(ofSize: 25), backgroundColor: .red, target: self, action: #selector(handleGo))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .cyan
        view.addSubview(btn)
        btn.centerInSuperview(size: .init(width: UIScreen.main.bounds.width-32, height: 80))
    }

   @objc func handleGo()  {
    let s = UIkitVC()
    
    
    s.modalPresentationStyle = .fullScreen
    present(s, animated: true, completion: nil)
    
    }

}

struct InfoVSCRespresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // leave this empty
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return UINavigationController(rootViewController: ViewController())
    }
}

struct InfoSVCPrseview: PreviewProvider {
    static var previews: some View {
        InfoVSCRespresentable()
    }
}


extension UIView {
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

}
