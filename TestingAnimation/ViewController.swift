//
//  ViewController.swift
//  TestingAnimation
//
//  Created by Дмитрий on 19.11.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    var isEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray.cgColor
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func startAnimation(_ sender: UIButton) {
        if !isEnabled {
            isEnabled = true
        sender.shake(duration: CFTimeInterval(0.3))
        } else {
            isEnabled = false
            sender.layer.removeAllAnimations()
        }
        
    }
    

}

extension UIView {
    func shake(duration: CFTimeInterval) {
        let translationY = CAKeyframeAnimation(keyPath: "transform.translation.y");
        translationY.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translationY.values = [-5, 2, 1, -3, -5, 4, -2, -3, 5]
        
        let translationX = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translationX.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translationX.values = [0, -3, -4, 2, 3, -5, 2, 1, -4, -1]
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [-18, -12, -3, 17, 14, -12, -3, 18].map {
            ( degrees: Double) -> Double in
            let radians: Double = (.pi * degrees) / 180.0
            return radians
        }
        
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [rotation, translationX, translationY]
        shakeGroup.duration = duration
        shakeGroup.autoreverses = true
        shakeGroup.repeatCount = .infinity
        self.layer.add(shakeGroup, forKey: "shakeIt")
    }
}

