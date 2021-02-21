//
//  Course.swift
//  Medha
//
//  Created by Ganesh Musini on 11/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import Foundation

struct Course : Decodable {
    
    let id : Int?
    let name : String?
    let link : String?
    let imageUrl : String?
    let number_of_lessons : Int?
    
}

struct Course_Desp : Decodable {

    let name : String
    let description : String
    let courses : [Course]
    
}
