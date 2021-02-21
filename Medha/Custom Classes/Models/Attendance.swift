//
//  Attendance.swift
//  Medha
//
//  Created by Ganesh Musini on 07/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import Foundation

class Attendance : NSObject,NSCoding, Decodable
{
    let status : String?
    let msg : String?
    let details : AttendaceDetails?

    required init(coder aDecoder: NSCoder)
    {
        self.status = aDecoder.decodeObject(forKey: "status") as? String
        self.msg = aDecoder.decodeObject(forKey: "msg") as? String
        self.details = aDecoder.decodeObject(forKey: "details") as? AttendaceDetails

    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(status, forKey: "status")
        aCoder.encode(msg, forKey: "msg")
        aCoder.encode(details, forKey: "details")
    }
    
}

class AttendaceDetails : NSObject,NSCoding,Decodable {
    
    let days_present : [PresentAbsentHolidays]?
    let days_leaves : [PresentAbsentHolidays]?
    let days_holiday : [PresentAbsentHolidays]?
    let total_working_days : Int?
    let total_present_days : Int?
    
    required init(coder aDecoder: NSCoder)
    {
        self.days_present = aDecoder.decodeObject(forKey: "days_present") as? [PresentAbsentHolidays]
        self.days_leaves = aDecoder.decodeObject(forKey: "days_leaves") as? [PresentAbsentHolidays]
        self.days_holiday = aDecoder.decodeObject(forKey: "days_holiday") as? [PresentAbsentHolidays]
        self.total_working_days = aDecoder.decodeObject(forKey: "total_working_days") as? Int
        self.total_present_days = aDecoder.decodeObject(forKey: "total_present_days") as? Int
    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(days_present, forKey: "days_present")
        aCoder.encode(days_leaves, forKey: "days_leaves")
        aCoder.encode(days_holiday, forKey: "days_holiday")
        aCoder.encode(total_working_days, forKey: "total_working_days")
        aCoder.encode(total_present_days, forKey: "total_present_days")
    }
}

class PresentAbsentHolidays: NSObject,NSCoding,Decodable {
    
    let date : String?
    let reason : String?
    
    required init(coder aDecoder: NSCoder)
    {
        self.date = aDecoder.decodeObject(forKey: "date") as? String
        self.reason = aDecoder.decodeObject(forKey: "reason") as? String

    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(reason, forKey: "reason")
    }
    
    
}


