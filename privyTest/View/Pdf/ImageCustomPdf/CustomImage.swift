//
//  CustomImage.swift
//  privyTest
//
//  Created by andyptra on 5/28/20.
//  Copyright © 2020 andyptra. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    var lastLocation:CGPoint?
    init(imageIcon: UIImage?, location:CGPoint) {
        super.init(image: imageIcon)
        self.lastLocation = location
        
        // MARK :: Draggable
        let draggable =  UIPanGestureRecognizer(target:self, action: #selector(handlePan))
        draggable.delegate = self
        self.addGestureRecognizer(draggable)
        
        // MARK :: Resize
        let resize = UIPinchGestureRecognizer(target: self, action: #selector(handlePin(pinch:)))
        resize.delegate = self
        self.addGestureRecognizer(resize)

        // MARK :: Rotate
        let rotate = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(recognizer:)))
        rotate.delegate = self
        self.addGestureRecognizer(rotate)
        
        
        self.center = location
        self.frame = CGRect(x: location.x, y: location.y, width: 150.0, height: 150.0)
        self.isUserInteractionEnabled = true
        self.isMultipleTouchEnabled = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.bringSubviewToFront(self)
        lastLocation = self.center
    }
    
}
extension CustomImageView : UIGestureRecognizerDelegate {
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self.superview!)
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self)
        }
    }
    
    @objc func handlePin(pinch: UIPinchGestureRecognizer) {
        
        if let view = pinch.view {
            view.transform = view.transform.scaledBy(x: pinch.scale, y: pinch.scale)
            pinch.scale = 1
        }
    }
    
    @objc func handleRotate(recognizer : UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    //MARK:- UIGestureRecognizerDelegate Methods
    func gestureRecognizer(_: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }
}
