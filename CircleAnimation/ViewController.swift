//
//  ViewController.swift
//  CircleAnimation
//
//  Created by Hsiao, Wayne on 6/29/18.
//  Copyright © 2018 Hsiao, Wayne. All rights reserved.
//

import UIKit
import Shape
import Animator

class ViewController: UIViewController {
    
    var gravity: UIGravityBehavior!
    var collider: UICollisionBehavior!
    var animator: UIDynamicAnimator!
    var rainAnimators: [AnyHashable:UIViewPropertyAnimator] = [:]
    var rains: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        
        let images = [#imageLiteral(resourceName: "winnie"), #imageLiteral(resourceName: "piglet"), #imageLiteral(resourceName: "eeyore"), #imageLiteral(resourceName: "heffalump")]
        for image in images {
            if let circleViewController = CircleViewController.controllerWith(image: image,
                                                                              delegate: self) {
                
                let randomX = CGFloat((arc4random() % UInt32(view.frame.width)))
                let minY = view.frame.minY - circleViewController.view.frame.height
                circleViewController.view.center = CGPoint(x: randomX, y: minY)
                
                addChildViewController(circleViewController)
                view.addSubview(circleViewController.view)
                circleViewController.didMove(toParentViewController: self)
                
                rains.append(circleViewController.view)
                
                startRain(circleViewController.view)
            }
        }
        applyCollisionTo(rains)
        randomBackgroundColor()
    }
    
    func randomBackgroundColor() {
        randomBackgroundColorWith(duration: 2.0) { [weak self] in
            self?.randomBackgroundColor()
        }
    }
    
    func applyGravityTo(view: UIView) {
//        gravity = UIGravityBehavior(items: [view])
//        gravity.magnitude = 0.020
//        animator.addBehavior(gravity)
    }
    
    func applyCollisionTo(_ views: [UIView]) {
        collider = UICollisionBehavior(items: views)
        collider.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collider)
    }
    
    func startRain(_ rain: UIView) {
        
        let index = rains.index {
            return $0 == rain
        }
        
        if let index = index,
            rainAnimators["\(index)"] != nil {
            return
        }
        
        let rainAnimator = UIViewPropertyAnimator(duration: randomDurantionFrom(5, to: 7),
                                                  curve: .linear)
        
        rainAnimator.addAnimations {
            let finalY = self.view.frame.maxY + rain.frame.height
            rain.center = CGPoint(x: rain.center.x, y: finalY)
        }
        
        rainAnimator.addCompletion { position in
            switch position {
            case .end:
                
                let minY = self.view.frame.minY - rain.frame.height
                let randomX = CGFloat((arc4random() % UInt32(self.view.frame.width)))
                rain.center = CGPoint(x: randomX,
                                      y: minY)
                
                let index = self.rains.index {
                    return $0 == rain
                }
                
                if let index = index {
                    self.rainAnimators.removeValue(forKey: "\(index)")
                }
                
                self.startRain(rain)
                
            default:
                break
            }
        }
        
        if let index = index {
            rainAnimators["\(index)"] = rainAnimator
            rainAnimator.startAnimation()
        } else {
            print("Not found")
        }
    }
}

extension ViewController: CircleViewControllerDelegate {
    @objc
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            
            if let view = sender.view {
                let index = rains.index {
                    return $0 == view
                }
                
                guard let indexToBeRemoved = index,
                    let rainAnimator = rainAnimators["\(indexToBeRemoved)"] else {
                        return
                }
                
                rainAnimators.removeValue(forKey: "\(indexToBeRemoved)")
                rainAnimator.stopAnimation(true)
            }

            break
        case .ended:
            
            if let view = sender.view {
                startRain(view)
            }
            
            break
        default:
            break
        }
        
        let translation = sender.translation(in: view)
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + translation.x,
                                  y: view.center.y + translation.y)
        }
        sender.setTranslation(.zero, in: view)
    }
}
