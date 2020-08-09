//
//  AlertService.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 04/08/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import UIKit

class AlertService: UIView {
    
    static let shared = AlertService()
    
    @IBOutlet private var mainView: UIView!
    @IBOutlet private weak var alertView: UIView!
    @IBOutlet private weak var topLogoImage: UIImageView!
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var doneButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlertService", owner: self, options: nil)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        doneButton.addTarget(self, action: #selector(didTapDoneButton(_:)), for: .touchUpInside)
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
        
        topLogoImage.layer.cornerRadius = 30
        topLogoImage.layer.borderColor = #colorLiteral(red: 0.9796836972, green: 0.2490850687, blue: 0.3219926953, alpha: 1)
        topLogoImage.layer.shadowRadius = 6.0
        topLogoImage.layer.borderWidth = 2
        
        backgroundImage.layer.shadowColor = UIColor.white.cgColor
        backgroundImage.layer.shadowRadius = 6.0
        
        mainView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.coordinateSpace.bounds.width, height: UIScreen.main.coordinateSpace.bounds.height)
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    func showAlert(image: UIImage, title: String, message: String, completion: (() -> Void)? = nil) {
        
        titleLabel.text = title
        messageLabel.text = message
        topLogoImage.image = image
        
        alertView.pulse()
        
        UIApplication.shared.windows.first{$0.isKeyWindow}?.addSubview(mainView)
        
    }
    
    @objc private func didTapDoneButton(_ : UIButton) {
        
        UIView.animate(withDuration: 0.5) {
            self.mainView.removeFromSuperview()
        }
        
    }
    
}

extension UIView {
    
    func pulse(){
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6//1.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = false//true
        pulse.repeatCount = 0//1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
        
    }

}

extension UIButton {
    
    func setGradientToButton(colorOne: UIColor, colorTwo: UIColor) {

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func formatarBotao(){
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
    }
    
    func pulses(){
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 1.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 100
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
    }
    
    func shake(){
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x - 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)
        
    }

}
