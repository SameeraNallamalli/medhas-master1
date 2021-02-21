//
//  UpdateAttendanceCell.swift
//  Medha
//
//  Created by Ganesh Musini on 17/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit

class UpdateAttendanceCell: UITableViewCell {
    @IBOutlet weak var lblRollNumber: UILabel!
    @IBOutlet weak var lblStudentName: UILabel!
    @IBOutlet weak var StatusSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        StatusSwitch.backgroundColor = .lightGray
        StatusSwitch.layer.cornerRadius = 16
        StatusSwitch.layer.masksToBounds = true
        
    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
