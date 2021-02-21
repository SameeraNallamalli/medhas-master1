//
//  AlertView.swift
//  Medha
//
//  Created by Ganesh Musini on 14/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit

class AlertView: NSObject {
        
    static let shared = AlertView()
    
    func showAlert(message:String, toView:UIViewController,ButtonTitles:[String]?,ButtonActions:[((UIAlertAction) -> Void)?])
    {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        
        for(index,btnTitle)in (ButtonTitles?.enumerated())!
        {
            
            let Action = UIAlertAction(title: btnTitle, style: .default, handler: ButtonActions[index])
                    
            alert.addAction(Action)
        }
                    
        toView.present(alert, animated: true, completion: nil)
    }

    
}
