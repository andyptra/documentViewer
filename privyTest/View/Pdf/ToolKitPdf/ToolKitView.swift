//
//  ToolKitView.swift
//  privyTest
//
//  Created by andyptra on 5/29/20.
//  Copyright © 2020 andyptra. All rights reserved.
//

import UIKit

class ToolKitView: UIView {
    @IBOutlet weak var thumbBtn: UIButton!
    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    
    class func instanceFromNib() -> ToolKitView {
        return UINib(nibName: "ToolKitView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ToolKitView
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 5
    }
    
}
