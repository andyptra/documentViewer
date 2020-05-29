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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configure(whitViewModel title:String) {
        
        titleLbl.text = title
    }
    class func nib() -> UINib {
        return UINib(nibName: "ListDataTableViewCell", bundle: nil)
    }
    
    
}
