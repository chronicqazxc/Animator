//
//  UIViewController+.swift
//  Animator
//
//  Created by Hsiao, Wayne on 6/30/18.
//  Copyright © 2018 Hsiao, Wayne. All rights reserved.
//

import UIKit

extension UIViewController {
    public func randomBackgroundColorWith(duration: TimeInterval, completeHandler: (()->())?) {
        let red   = Float((arc4random() % 256)) / 255.0
        let green = Float((arc4random() % 256)) / 255.0
        let blue  = Float((arc4random() % 256)) / 255.0
        let alpha = Float(1.0)
        
        let backgroundColorAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut)
        backgroundColorAnimator.addAnimations {
            self.view.backgroundColor = UIColor(red: CGFloat(red),
                                                green: CGFloat(green),
                                                blue: CGFloat(blue),
                                                alpha: CGFloat(alpha))
        }
        backgroundColorAnimator.addCompletion { _ in
            if let completeHandler = completeHandler {
                completeHandler()
            }
        }
        backgroundColorAnimator.startAnimation()
    }
}
