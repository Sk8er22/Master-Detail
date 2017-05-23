//
//  CellPosts.swift
//  TestC
//
//  Created by PEDRO ARMANDO MANFREDI on 23/5/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

class CellPosts: UITableViewCell {
    
    @IBOutlet weak var titlePosts: UILabel!
    @IBOutlet weak var bodyPosts: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
