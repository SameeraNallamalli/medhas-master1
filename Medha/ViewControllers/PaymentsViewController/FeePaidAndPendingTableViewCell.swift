//
//  FeePaidAndPendingTableViewCell.swift
//  Medha
//
//  Created by Ganesh Musini on 08/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit

class FeePaidAndPendingTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var btnView: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
