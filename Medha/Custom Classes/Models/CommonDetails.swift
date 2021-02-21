//
//  Details.swift
//  Medha
//
//  Created by Ganesh on 31/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import Foundation

class CommonDetails: NSObject,NSCoding, Decodable
{
    let id : Int?
    let student_id : Int?
    let fullname : String?
    let subject : String?
    let `class` : String?
    let section : String?
    let marks : Int?
    let date : String?
    let upload_document : String?
    let profile_summary : String?
    let profile_pic : String?
    let content : String?
    let uploads : String?
    let student_name : String?
    let cls : String?
    let min_marks : Int?
    let max_marks : Int?
    let exam_type : String?
    let exam_date : String?
    let teacher_name : String?
    let secured_marks :Int?
    
    let fees_type : String?
    let total_amount : Int?
    let pending_amount : Int?
    let fees_details : [feesDetails]?
    
    //Holidays
    let title : String?
    let start : String?
    
    required init(coder aDecoder: NSCoder)
    {
        self.id = aDecoder.decodeObject(forKey: "id") as? Int
        self.student_id = aDecoder.decodeObject(forKey: "student_id") as? Int
        self.fullname = aDecoder.decodeObject(forKey: "fullname") as? String
        self.subject = aDecoder.decodeObject(forKey: "subject") as? String
        self.class = aDecoder.decodeObject(forKey: "class") as? String
        self.section = aDecoder.decodeObject(forKey: "section") as? String
        self.marks = aDecoder.decodeObject(forKey: "marks") as? Int
        self.date = aDecoder.decodeObject(forKey: "date") as? String
        self.upload_document = aDecoder.decodeObject(forKey: "upload_document") as? String
        self.profile_summary = aDecoder.decodeObject(forKey: "profile_summary") as? String
        self.profile_pic = aDecoder.decodeObject(forKey: "profile_pic") as? String
        self.content = aDecoder.decodeObject(forKey: "content") as? String
        self.uploads = aDecoder.decodeObject(forKey: "uploads") as? String
        self.student_name = aDecoder.decodeObject(forKey: "student_name") as? String
        self.cls = aDecoder.decodeObject(forKey: "cls") as? String
        self.min_marks = aDecoder.decodeObject(forKey: "min_marks") as? Int
        self.max_marks = aDecoder.decodeObject(forKey: "max_marks") as? Int
        self.exam_type = aDecoder.decodeObject(forKey: "exam_type") as? String
        self.exam_date = aDecoder.decodeObject(forKey: "exam_date") as? String
        self.teacher_name = aDecoder.decodeObject(forKey: "teacher_name") as? String
        self.fees_type = aDecoder.decodeObject(forKey: "fees_type") as? String
        self.secured_marks = aDecoder.decodeObject(forKey: "secured_marks") as? Int
        self.total_amount = aDecoder.decodeObject(forKey: "total_amount") as? Int
        self.pending_amount = aDecoder.decodeObject(forKey: "pending_amount") as? Int
        self.fees_details = aDecoder.decodeObject(forKey: "fees_details") as? [feesDetails]
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.start = aDecoder.decodeObject(forKey: "start") as? String
    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(student_id, forKey: "student_id")
        aCoder.encode(self.fullname, forKey: "fullname")
        aCoder.encode(self.subject, forKey: "subject")
        aCoder.encode(self.class, forKey: "class")
        aCoder.encode(self.section, forKey: "section")
        aCoder.encode(self.marks, forKey: "marks")
        aCoder.encode(self.date, forKey: "date")
        aCoder.encode(self.upload_document, forKey: "upload_document")
        aCoder.encode(self.profile_summary, forKey: "profile_summary")
        aCoder.encode(self.profile_pic, forKey: "profile_pic")
        aCoder.encode(self.content, forKey: "content")
        aCoder.encode(self.uploads, forKey: "uploads")
        aCoder.encode(self.student_name, forKey: "student_name")
        aCoder.encode(self.cls, forKey: "cls")
        aCoder.encode(self.min_marks, forKey: "min_marks")
        aCoder.encode(self.max_marks, forKey: "max_marks")
        aCoder.encode(self.exam_type, forKey: "exam_type")
        aCoder.encode(self.exam_date, forKey: "exam_date")
        aCoder.encode(self.teacher_name, forKey: "teacher_name")
        aCoder.encode(self.secured_marks, forKey: "secured_marks")
        aCoder.encode(self.fees_type, forKey: "fees_type")
        aCoder.encode(self.total_amount, forKey: "total_amount")
        aCoder.encode(self.pending_amount, forKey: "pending_amount")
        aCoder.encode(self.fees_details, forKey: "fees_details")
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.start, forKey: "start")
    }
    
}

class feesDetails : NSObject,NSCoding, Decodable
{
    let date : String?
    let amount_paid : String?
    let payment_path : String?

    required init(coder aDecoder: NSCoder)
    {
        self.date = aDecoder.decodeObject(forKey: "date") as? String
        self.amount_paid = aDecoder.decodeObject(forKey: "amount_paid") as? String
        self.payment_path = aDecoder.decodeObject(forKey: "payment_path") as? String

    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(amount_paid, forKey: "amount_paid")
        aCoder.encode(self.payment_path, forKey: "payment_path")
    }
    
}
