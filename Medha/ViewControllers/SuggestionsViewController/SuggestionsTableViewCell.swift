//
//  SuggestionsTableViewCell.swift
//  Medha
//
//  Created by Ganesh Musini on 19/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit

class SuggestionsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var lblSection: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var StackNameFields: UIStackView!
    @IBOutlet weak var btnShowMore: UIButton!
    @IBOutlet weak var lblLink: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        StackNameFields.addBorder(vBorders: [.Bottom], color: .orange, width: 0.0)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
