//
//  HallInfoTableViewCell.swift
//  Easy_Wedding
//
//  Created by maaz bin tausif on 19/07/2020.
//  Copyright © 2020 maaz bin tausif. All rights reserved.
//

import UIKit

class HallInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_HallName: UILabel!
    @IBOutlet weak var lbl_NoOfPeople: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    @IBOutlet weak var hallImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
