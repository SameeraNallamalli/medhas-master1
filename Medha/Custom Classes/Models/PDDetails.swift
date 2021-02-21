//
//  PDDetails.swift
//  Medha
//
//  Created by Ganesh Musini on 25/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import Foundation
class PDData : NSObject,NSCoding, Decodable
{
    let status : String?
    let msg : String?
    let details : [PDDetails]?

    required init(coder aDecoder: NSCoder)
    {
        self.status = aDecoder.decodeObject(forKey: "status") as? String
        self.msg = aDecoder.decodeObject(forKey: "msg") as? String
        self.details = aDecoder.decodeObject(forKey: "details") as? [PDDetails]

    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(status, forKey: "status")
        aCoder.encode(msg, forKey: "msg")
        aCoder.encode(details, forKey: "details")
    }
    
}
class PDDetails: NSObject,NSCoding, Decodable
{
    let id : Int?
    let `class` : String?
    let subject : String?
    let category: String?
    let sub_category : String?
    let content_heading: String?
    let content: String?
    let content_link : String?
    let status : String?
    let submitted_date : String?
    
    required init(coder aDecoder: NSCoder)
    {
        self.id = aDecoder.decodeObject(forKey: "id") as? Int
        self.class = aDecoder.decodeObject(forKey: "class") as? String
        self.subject = aDecoder.decodeObject(forKey: "subject") as? String
        self.category = aDecoder.decodeObject(forKey: "category") as? String
        self.sub_category = aDecoder.decodeObject(forKey: "sub_category") as? String
        self.content_heading = aDecoder.decodeObject(forKey: "content_heading") as? String
        self.content = aDecoder.decodeObject(forKey: "content") as? String
        self.content_link = aDecoder.decodeObject(forKey: "content_link") as? String
        self.status = aDecoder.decodeObject(forKey: "status") as? String
        self.submitted_date = aDecoder.decodeObject(forKey: "submitted_date") as? String

    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(self.class, forKey: "class")
        aCoder.encode(self.subject, forKey: "subject")
        aCoder.encode(category, forKey: "category")
        aCoder.encode(self.sub_category, forKey: "sub_category")
        aCoder.encode(content_heading, forKey: "content_heading")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(content_link, forKey: "content_link")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(submitted_date, forKey: "submitted_date")
       
    }
    
}
