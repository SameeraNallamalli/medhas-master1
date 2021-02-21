//
//  ResultsTableViewCell.swift
//  Medha
//
//  Created by Ganesh Musini on 26/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblSub: UILabel!
    @IBOutlet weak var lblMaxMarks: UILabel!
    @IBOutlet weak var lblSecuredMarks: UILabel!
    @IBOutlet weak var lblStudentName: UILabel!
    @IBOutlet weak var lblRollNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
