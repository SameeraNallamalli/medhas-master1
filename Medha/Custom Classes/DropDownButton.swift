//
//  DropDownButton.swift
//  Medha
//
//  Created by Ganesh Musini on 26/02/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit

class DropDownButton: UIButton {
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
        }
    }

}
