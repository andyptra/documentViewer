//
//  ListDataTableViewCell.swift
//  privyTest
//
//  Created by andyptra on 5/27/20.
//  Copyright © 2020 andyptra. All rights reserved.
//

import UIKit

class ListDataTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK : configure view
    func configure(whitViewModel title:String) {
        titleLbl.text = title
    }
    
    //MARK : setting xib
    class func nib() -> UINib {
        return UINib(nibName: "ListDataTableViewCell", bundle: nil)
    }
    
    //MARK : setup UI
    func setupUI() {
        let borderColor : UIColor = UIColor( red: 204.0, green: 204.0, blue:204.0, alpha: 1.0 )
        subView.layer.borderColor = borderColor.cgColor
        subView.layer.shadowColor = UIColor.black.cgColor
        subView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        subView.layer.shadowOpacity = 0.2
        subView.layer.shadowRadius = 5.0
        subView.layer.cornerRadius = 5.0
        subView.layer.masksToBounds = false
    }
}
