//
//  Constants.swift
//  Medha
//
//  Created by Ganesh Musini on 30/11/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

//let baseURL                 =   "http://120.138.9.164:9090/ws/" // Production
let baseURL                 =   "http://3.6.87.95:9090/ws/" // Production

//let baseURL                 =   "http://10.10.22.49:9090/ws/" // Local

let verifyAccount           =   "\(baseURL)verifyAccount"
let updatePassword          =   "\(baseURL)updatePassword"
let accountLogin            =   "\(baseURL)accountLogin"
let registerAccount         =   "\(baseURL)sendOTP"
let getAttendanceByMonth    =   "\(baseURL)getAttendanceByMonth"
let getDefaultLists         =   "\(baseURL)getDefaultLists"
let postSuggestion          =   "\(baseURL)postSuggestion"
let postComplaint           =   "\(baseURL)postComplaint"
let getSuggestions          =   "\(baseURL)getSuggestions"
let getComplaints           =   "\(baseURL)getComplaints"
let getPDDetails            =   "\(baseURL)getPDDetails"
let getTutorialDetails      =   "\(baseURL)getTutorialDetails"
let postPD                  =   "\(baseURL)postPD"
let postTutorial            =   "\(baseURL)postTutorial"
let getStudentsByClass      =   "\(baseURL)getStudentsByClass"
let addAbsentees            =   "\(baseURL)addAbsentees"
let getHomeWorkByStudent    =   "\(baseURL)getHomeWorkByStudent"
let postHomeWork            =   "\(baseURL)postHomeWork"
let getSubjectInfo          =   "\(baseURL)getSubjectInfo"
let postWorksheet           =   "\(baseURL)postWorksheet"
let getWorkSheetDetails     =   "\(baseURL)getWorkSheetDetails"
let getResultsByClassSubject =  "\(baseURL)getResultsByClassSubject"
let getResultsByStudentId   =   "\(baseURL)getResultsByStudentId"
let getPaymentsByYear       =   "\(baseURL)getPaymentsByYear"
let updateUserAddress       =   "\(baseURL)updateUserAddress"
let getHolidays             =   "\(baseURL)getHolidays"

let MainSB: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

let courseURL = "https://api.letsbuildthatapp.com/jsondecodable/course"
let coursesURL = "https://api.letsbuildthatapp.com/jsondecodable/courses"
let courseDespURL = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
let coueseMissingFieldsURL = "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"

let kForgotPassword = "Forgot Password"
let kNewUser = "New User"
let kLogin  = "Login"
let kRegister = "Register"
let kHW_images = "Images"
let kHW_videos =  "Videos"
let appDelegate = UIApplication.shared.delegate as! AppDelegate
var context:NSManagedObjectContext!  = appDelegate.persistentContainer.viewContext
let newLine = "\n"
let mime_image = "image/png"
let mime_file = "application/pdf"
let mime_allTypes = "application/pdf/image/png"
let pushKey = "PUSH"

let DF_yyyy_MM_DD = "yyyy-MM-dd"
let DF_Month_DD_yyyy = "MMM d, yyyy"
let DF_MM_dd_yyyy = "MM-dd-yyyy"
let DF_dd_MM_yyyy = "dd-MM-yyyy"

// Storyboard Segues
let segue_Payments = "segue_Payments"
let segue_Attendance = "segue_Attendance"
let segue_SubjectInfo = "segue_Subject_Info"
let segue_Complaints = "segue_Complaints"
let segue_Suggestions = "segue_Suggestions"
let segue_Homework = "segue_Homework"
let segue_imagesOrVideos = "segue_images_Videos"
let segue_FeeDetails = "segue_FeeDetails"
let segue_Tutorials = "segue_Tutorials"
let segue_TutorialDetails = "segue_TutorialDetails"
let segue_PD = "segue_PD"
let segue_PDDetails = "segue_PDDetails"
let segue_Profile = "segue_Profile"
let segue_ContactUs = "segue_ContactUs"
let segue_SchoolImgTypes = "segue_SchoolImgTypes"
let segue_SchoolImages = "segue_SchoolImages"
let segue_Attendance_Teacher = "segue_Attendance_Teacher"
let segue_ShowSuggestionOrComplaints = "segue_ShowSuggestionOrComplaints"
let segue_Results = "segue_Results"
let segue_Worksheets = "segue_Worksheets"
let segue_worksheets_Upload = "segue_worksheets_Upload"
let segue_Results_Teacher = "segue_Results_Teacher"
let segue_Calendar = "segue_Calendar"
// Testing


