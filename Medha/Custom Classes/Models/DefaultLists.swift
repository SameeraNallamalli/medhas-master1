//
//  DefaultLists.swift
//  Medha
//
//  Created by Ganesh Musini on 09/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import Foundation

class DefaultLists : NSObject,NSCoding,Decodable {
    
    let status : String?
    let msg : String?
    let classes : [defaultList]?
    let subjects : [defaultList]?
    let sections : [defaultList]?
    let suggestions : [defaultList]?
    let complaints : [defaultList]?
    let personality_development : [defaultList]?
    let tutorials : [defaultList]?
    let exam_details : [defaultList]?
    let fees_details : [defaultList]?
    
    required init(coder aDecoder: NSCoder)
    {
        self.status = aDecoder.decodeObject(forKey: "status") as? String
        self.msg = aDecoder.decodeObject(forKey: "msg") as? String
        self.classes = aDecoder.decodeObject(forKey: "classes") as? [defaultList]
        self.subjects = aDecoder.decodeObject(forKey: "subjects") as? [defaultList]
        self.sections = aDecoder.decodeObject(forKey: "sections") as? [defaultList]
        self.suggestions = aDecoder.decodeObject(forKey: "suggestions") as? [defaultList]
        self.complaints = aDecoder.decodeObject(forKey: "complaints") as?  [defaultList]
        self.personality_development = aDecoder.decodeObject(forKey: "personality_development") as? [defaultList]
        self.tutorials = aDecoder.decodeObject(forKey: "tutorials") as?  [defaultList]
        self.exam_details = aDecoder.decodeObject(forKey: "exam_details") as?  [defaultList]
        self.fees_details = aDecoder.decodeObject(forKey: "fees_details") as?  [defaultList]
    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(status, forKey: "status")
        aCoder.encode(msg, forKey: "msg")
        aCoder.encode(classes, forKey: "classes")
        aCoder.encode(subjects, forKey: "subjects")
        aCoder.encode(sections, forKey: "sections")
        aCoder.encode(suggestions, forKey: "suggestions")
        aCoder.encode(complaints, forKey: "complaints")
        aCoder.encode(personality_development, forKey: "personality_development")
        aCoder.encode(tutorials, forKey: "tutorials")
        aCoder.encode(exam_details, forKey: "exam_details")
        aCoder.encode(fees_details, forKey: "fees_details")
    }
}


class defaultList: NSObject,NSCoding,Decodable {
    
    let name : String?
    let id : Int?
    let sub_category : [SubcategoryList]?
    
    
    required init(coder aDecoder: NSCoder)
    {
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.id = aDecoder.decodeObject(forKey: "id") as? Int
        self.sub_category = aDecoder.decodeObject(forKey: "sub_category") as?  [SubcategoryList]
    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(sub_category, forKey: "sub_category")
    }
    
}
class SubcategoryList: NSObject,NSCoding,Decodable {
    
    let name : String?
    let id : Int?
        
    required init(coder aDecoder: NSCoder)
    {
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.id = aDecoder.decodeObject(forKey: "id") as? Int

    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(id, forKey: "id")
    }
    
}
