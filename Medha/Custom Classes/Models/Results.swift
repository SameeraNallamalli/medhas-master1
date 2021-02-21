//
//  Results_teacher.swift
//  Medha
//
//  Created by Ganesh on 21/02/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import Foundation

class Results : NSObject,NSCoding, Decodable
{
    let status : String?
    let msg : String?
    let details : [CommonDetails]?

    required init(coder aDecoder: NSCoder)
    {
        self.status = aDecoder.decodeObject(forKey: "status") as? String
        self.msg = aDecoder.decodeObject(forKey: "msg") as? String
        self.details = aDecoder.decodeObject(forKey: "details") as? [CommonDetails]

    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(status, forKey: "status")
        aCoder.encode(msg, forKey: "msg")
        aCoder.encode(details, forKey: "details")
    }
    
}
