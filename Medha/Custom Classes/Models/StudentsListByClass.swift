//
//  StudentsListByClass.swift
//  Medha
//
//  Created by Ganesh Musini on 28/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import Foundation
class StudentsListByClass : NSObject,NSCoding, Decodable
{
    let status : String?
    let msg : String?
    let details : [StudentDetails]?

    required init(coder aDecoder: NSCoder)
    {
        self.status = aDecoder.decodeObject(forKey: "status") as? String
        self.msg = aDecoder.decodeObject(forKey: "msg") as? String
        self.details = aDecoder.decodeObject(forKey: "details") as? [StudentDetails]

    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(status, forKey: "status")
        aCoder.encode(msg, forKey: "msg")
        aCoder.encode(details, forKey: "details")
    }
    
}
class StudentDetails: NSObject,NSCoding, Decodable
{
    let id : Int?
    let fullname : String?
    let email: String?
    let register_num: String?
    let profile_pic: String?
    
    required init(coder aDecoder: NSCoder)
    {
        self.id = aDecoder.decodeObject(forKey: "id") as? Int
        self.fullname = aDecoder.decodeObject(forKey: "fullname") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.register_num = aDecoder.decodeObject(forKey: "register_num") as? String
        self.profile_pic = aDecoder.decodeObject(forKey: "profile_pic") as? String
    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(fullname, forKey: "fullname")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(register_num, forKey: "register_num")
        aCoder.encode(profile_pic, forKey: "profile_pic")
       
    }
    
}
