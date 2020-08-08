//
//  CustomTableViewCell.swift
//  yazboz
//
//  Created by Orhan Erbas on 31.07.2020.
//  Copyright © 2020 Orhan Erbas. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var counterLbl: UILabel!
    
    @IBOutlet weak var user1Lbl: UILabel!
    @IBOutlet weak var user2Lbl: UILabel!
    @IBOutlet weak var user3Lbl: UILabel!
    @IBOutlet weak var user4Lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
