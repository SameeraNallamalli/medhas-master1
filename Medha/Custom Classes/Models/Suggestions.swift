//
//  Suggestions.swift
//  Medha
//
//  Created by Ganesh Musini on 13/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import Foundation
class Suggestions : NSObject,NSCoding, Decodable
{
    let status : String?
    let msg : String?
    let details : [SuggestionDetails]?

    required init(coder aDecoder: NSCoder)
    {
        self.status = aDecoder.decodeObject(forKey: "status") as? String
        self.msg = aDecoder.decodeObject(forKey: "msg") as? String
        self.details = aDecoder.decodeObject(forKey: "details") as? [SuggestionDetails]

    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(status, forKey: "status")
        aCoder.encode(msg, forKey: "msg")
        aCoder.encode(details, forKey: "details")
    }
    
}
class SuggestionDetails: NSObject,NSCoding, Decodable
{
    let id : Int?
    let area: String?
    let `class` : String?
    let section: String?
    let content: String?
    let full_name : String?
    let submitted_date : String?
    
    required init(coder aDecoder: NSCoder)
    {
        self.id = aDecoder.decodeObject(forKey: "id") as? Int
        self.area = aDecoder.decodeObject(forKey: "area") as? String
        self.class = aDecoder.decodeObject(forKey: "class") as? String
        self.section = aDecoder.decodeObject(forKey: "section") as? String
        self.content = aDecoder.decodeObject(forKey: "content") as? String
        self.full_name = aDecoder.decodeObject(forKey: "full_name") as? String
        self.submitted_date = aDecoder.decodeObject(forKey: "submitted_date") as? String
    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(area, forKey: "area")
        aCoder.encode(self.class, forKey: "class")
        aCoder.encode(section, forKey: "section")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(full_name, forKey: "full_name")
        aCoder.encode(submitted_date, forKey: "submitted_date")
       
    }
    
}
