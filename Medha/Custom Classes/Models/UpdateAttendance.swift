//
//  UpdateAttendance.swift
//  Medha
//
//  Created by Ganesh Musini on 21/03/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import Foundation

class UpdateAttendance : NSObject,NSCoding,Decodable {
    
    let id : Int?
    let `class` : String?
    let section : String?
    let dateString : String?
    let status : String?
    
    required init(coder aDecoder: NSCoder)
    {
        self.id = aDecoder.decodeObject(forKey: "id") as? Int
        self.class = aDecoder.decodeObject(forKey: "class") as? String
        self.section = aDecoder.decodeObject(forKey: "section") as? String
        self.dateString = aDecoder.decodeObject(forKey: "dateString") as? String
        self.status = aDecoder.decodeObject(forKey: "status") as? String
    }
        
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(self.class, forKey: "class")
        aCoder.encode(self.section, forKey: "section")
        aCoder.encode(self.dateString, forKey: "dateString")
        aCoder.encode(self.status, forKey: "status")
    }
    
    
}
