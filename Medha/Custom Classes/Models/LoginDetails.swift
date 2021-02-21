//
//  LoginDetails.swift
//  Medha
//
//  Created by Ganesh Musini on 14/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import Foundation

class LoginDetails : NSObject,NSCoding, Decodable
{
    let status : String?
    let msg : String?
    let details : [details]?

    required init(coder aDecoder: NSCoder)
    {
        self.status = aDecoder.decodeObject(forKey: "status") as? String
        self.msg = aDecoder.decodeObject(forKey: "msg") as? String
        self.details = aDecoder.decodeObject(forKey: "details") as? [details]

    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(status, forKey: "status")
        aCoder.encode(msg, forKey: "msg")
        aCoder.encode(details, forKey: "details")
    }
    
}

class details : NSObject,NSCoding,Decodable {
    
    let id : Int?
    let fullname : String?
    let email : String?
    let mobile : String?
    let roles : Int?
    let register_num : String?
    let surname : String?
    let father_spouse : String?
    let gender : String?
    let nationality : String?
    let blood_group : String?
    let class_education : String?
    let parent_phone_number : String?
    var address : String?
    let profile_summary : String?
    let subjects_handled : String?
    let class_handled : String?
    let profile_pic : String?
    let account_verified : Int?
    let msg : String?
    let section : String?
    let subj_class_handled : [SubClassHandled]?
    let class_name : String?
    let section_name : String?
    let qualification_name : String?
    
    required init(coder aDecoder: NSCoder)
    {
        self.id = aDecoder.decodeObject(forKey: "id") as? Int
        self.fullname = aDecoder.decodeObject(forKey: "fullname") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.mobile = aDecoder.decodeObject(forKey: "mobile") as? String
        self.roles = aDecoder.decodeObject(forKey: "roles") as? Int
        self.register_num = aDecoder.decodeObject(forKey: "register_num") as? String
        self.surname = aDecoder.decodeObject(forKey: "surname") as? String
        self.father_spouse = aDecoder.decodeObject(forKey: "father_spouse") as? String
        self.gender = aDecoder.decodeObject(forKey: "gender") as? String
        self.nationality = aDecoder.decodeObject(forKey: "nationality") as? String
        self.blood_group = aDecoder.decodeObject(forKey: "blood_group") as? String
        self.class_education = aDecoder.decodeObject(forKey: "class_education") as? String
        self.parent_phone_number = aDecoder.decodeObject(forKey: "parent_phone_number") as? String
        self.address = aDecoder.decodeObject(forKey: "address") as? String
        self.profile_summary = aDecoder.decodeObject(forKey: "profile_summary") as? String
        self.subjects_handled = aDecoder.decodeObject(forKey: "subjects_handled") as? String
        self.class_handled = aDecoder.decodeObject(forKey: "class_handled") as? String
        self.profile_pic = aDecoder.decodeObject(forKey: "profile_pic") as? String
        self.account_verified = aDecoder.decodeObject(forKey: "account_verified") as? Int
        self.msg = aDecoder.decodeObject(forKey: "msg") as? String
        self.section = aDecoder.decodeObject(forKey: "section") as? String
        self.subj_class_handled = aDecoder.decodeObject(forKey: "subj_class_handled") as? [SubClassHandled]
        self.class_name = aDecoder.decodeObject(forKey: "class_name") as? String
        self.section_name = aDecoder.decodeObject(forKey: "section_name") as? String
        self.qualification_name = aDecoder.decodeObject(forKey: "qualification_name") as? String
    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(fullname, forKey: "fullname")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(mobile, forKey: "mobile")
        aCoder.encode(roles, forKey: "roles")
        aCoder.encode(register_num, forKey: "register_num")
        aCoder.encode(surname, forKey: "surname")
        aCoder.encode(father_spouse, forKey: "father_spouse")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(nationality, forKey: "nationality")
        aCoder.encode(blood_group, forKey: "blood_group")
        aCoder.encode(class_education, forKey: "class_education")
        aCoder.encode(parent_phone_number, forKey: "parent_phone_number")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(profile_summary, forKey: "profile_summary")
        aCoder.encode(subjects_handled, forKey: "subjects_handled")
        aCoder.encode(class_handled, forKey: "class_handled")
        aCoder.encode(profile_pic, forKey: "profile_pic")
        aCoder.encode(account_verified, forKey: "account_verified")
        aCoder.encode(msg, forKey: "msg")
        aCoder.encode(section, forKey: "section")
        aCoder.encode(subj_class_handled, forKey: "subj_class_handled")
        aCoder.encode(class_name, forKey: "class_name")
        aCoder.encode(section_name, forKey: "section_name")
        aCoder.encode(qualification_name, forKey: "qualification_name")
    }
}

class SubClassHandled : NSObject,NSCoding, Decodable
{
    let subject_id : String?
    let subject_name : String?
    let class_id : String?
    let class_name : String?
    let section_id : String?
    let section_name : String?
    
    required init(coder aDecoder: NSCoder)
    {
        self.subject_id = aDecoder.decodeObject(forKey: "subject_id") as? String
        self.subject_name = aDecoder.decodeObject(forKey: "subject_name") as? String
        self.class_id = aDecoder.decodeObject(forKey: "class_id") as? String
        self.class_name = aDecoder.decodeObject(forKey: "class_name") as? String
        self.section_id = aDecoder.decodeObject(forKey: "section_id") as? String
        self.section_name = aDecoder.decodeObject(forKey: "section_name") as? String

    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(subject_id, forKey: "subject_id")
        aCoder.encode(subject_name, forKey: "subject_name")
        aCoder.encode(class_id, forKey: "class_id")
        aCoder.encode(class_name, forKey: "class_name")
        aCoder.encode(section_id, forKey: "section_id")
        aCoder.encode(section_name, forKey: "section_name")
    }
    
}
