//
//  ThumbnailCollectionViewCell.swift
//  privyTest
//
//  Created by andyptra on 5/29/20.
//  Copyright © 2020 andyptra. All rights reserved.
//

import UIKit

class ThumbnailCollectionViewCell: UICollectionViewCell {
    
    open var imageThumb: UIImage? = nil {
        didSet {
            thumbView.image = imageThumb
        }
    }
    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var pages: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
