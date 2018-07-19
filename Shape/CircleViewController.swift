//
//  CircleViewController.swift
//  Shape
//
//  Created by Hsiao, Wayne on 6/30/18.
//  Copyright © 2018 Hsiao, Wayne. All rights reserved.
//

import UIKit

@objc
public protocol CircleViewControllerDelegate: AnyObject {
    @objc func handlePan(_ :UIPanGestureRecognizer)
}

public class CircleViewController: UIViewController {
    
    @IBOutlet weak var circleView: CircleView?
    
    weak var delegate: CircleViewControllerDelegate?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public static func controllerWith(image: UIImage,
                                      delegate: CircleViewControllerDelegate? = nil) -> CircleViewController? {
        
        let storyboard = UIStoryboard(name: "CircleViewController", bundle: Bundle(for: CircleViewController.self))
        guard let circleViewController = storyboard.instantiateViewController(withIdentifier: "CircleViewController") as? CircleViewController else {
            return nil
        }
        
        circleViewController.circleView = CircleView.circleViewWith(frame: circleViewController.view.frame, image: image)
        guard let circleView = circleViewController.circleView else {
            return nil
        }
        
        circleViewController.view.layer.masksToBounds = circleView.layer.masksToBounds
        circleViewController.view.layer.borderWidth = circleView.layer.borderWidth
        circleViewController.view.layer.cornerRadius = circleView.layer.cornerRadius
        circleViewController.view.frame = circleView.frame
        circleViewController.view.addSubview(circleView)
        circleViewController.view.center = CGPoint(x: circleViewController.view.center.x,
                                                   y: circleViewController.view.center.y -
                                                    circleViewController.view.frame.height)
        
        if let delegate = delegate {
            let panGesture = UIPanGestureRecognizer(target: delegate,
                                                    action: #selector(delegate.handlePan(_:)))
            circleViewController.view.addGestureRecognizer(panGesture)
        }
        
        return circleViewController
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

//    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
//        let translation = sender.translation(in: view)
//        if let view = sender.view {
//            view.center = CGPoint(x: view.center.x + translation.x,
//                                  y: view.center.y + translation.y)
//        }
//        sender.setTranslation(.zero, in: view)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
