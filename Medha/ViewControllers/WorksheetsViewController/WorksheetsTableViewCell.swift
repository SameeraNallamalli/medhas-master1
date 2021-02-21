//
//  WorksheetsTableViewCell.swift
//  Medha
//
//  Created by Ganesh on 05/02/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit

class WorksheetsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblSubmussionDate: UILabel!
    @IBOutlet weak var lblMarks: UILabel!
    @IBOutlet weak var lblView: UILabel!
    @IBOutlet weak var lblStudentUpload: UILabel!
    @IBOutlet weak var btnUploadView: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
