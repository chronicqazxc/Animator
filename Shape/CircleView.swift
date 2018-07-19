//
//  CircleView.swift
//  CircleAnimation
//
//  Created by Hsiao, Wayne on 6/29/18.
//  Copyright © 2018 Hsiao, Wayne. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {
    
    @IBOutlet weak fileprivate var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFit
        }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get {
            guard let borderColor = layer.borderColor else {
                return UIColor.white
            }
            return UIColor(cgColor: borderColor)
        }
        
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var cornerRadious: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            if newValue >= 0 {
                layer.masksToBounds = true
            }
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
    static func circleViewWith(frame: CGRect, image: UIImage) -> CircleView? {
        if let firstView = Bundle(for: CircleView.self).loadNibNamed("CircleView",
                                                                     owner: self,
                                                                     options: nil)?.first,
            let circleView = firstView as? CircleView {
            circleView.imageView.image = image
            return circleView
        } else {
            return nil
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
