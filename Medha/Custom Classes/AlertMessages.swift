//
//  AlertMessages.swift
//  Medha
//
//  Created by Ganesh Musini on 30/11/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import Foundation


#if DEBUG
let Alert_Empty_UserID = "User ID should not be empty"
#else
let Alert_Empty_UserID = "User ID should't be empty"
#endif

let Alert_Invalid_UserID = "Please enter valid mobile number"
let Alert_Empty_Password = "Password should not be empty"
let Alert_Empty_OTP = "Enter the OTP to continue"
let Alert_No_Internet = "The internet connection appears to be offline"
let Alert_Server_error = "Some thing went wrong, server not responding"
let Alert_OTP_Success = "Account verified successfully, please set password to continue"
let Alert_OTP_Failure = "Invalid OTP"
let Alert_Empty_Fields = "Fields should not be empty"
let Alert_SetPass_NotMatch = "Passwords mismatch"
let Alert_SetPass_Success = "Success!,Please login to continue"
let Alert_Invaid_ID_Pass = "Invalid Email or Password"
let Alert_login_Success = "Login Success"
let Alert_OTP_Sent = "OTP sent successfully"
let Alert_EmptySlectedDate = "Please select date to proceed"
let Alert_EmptySlectedClass = "Please select class to proceed"
let Alert_EmptySlectedSection = "Please select section to proceed"
let Alert_EmptySlectedSubject = "Please select subject to proceed"
let Alert_Suggestion_Success = "Thank you!\(newLine)We will get back you soon"
let Alert_Complaint_Success = "Complaints sent successfully\(newLine)We will get back you soon"
let Alert_Delete_HW_Image   =  "Do you want delete this photo?"
let Alert_Save_HW_Image   =  "Do you want save this photo?"
let Alert_StatusCode_Fail = "Not a success status code"
let Alert_Success_Attendance = "Attendance updated"
let Alert_Full_Attendance = "This will be marked as present for all the students of this class, are you sure?"
let Alert_HW_ImageUplaodImgLimitError = "You can upload maximum of 3 photos only"
let Alert_Empty_HW_ContentOrImg = "Please add either of content and images or both if available"
let Alert_Empty_StudentList = "No Students available for this filter"
let Alert_Empty_Category    = "Please select Category"
let Alert_Empty_SubCategory    = "Please select SubCategory"
let Alert_Empty_Comments = "Plese add your comments"
let Alert_NoWorksheets = "No worksheets available for this selection criteria"
let Alert_NoHomeWork = "No Homework available for you on selected date"
let Alert_NoResults = "No Results available"
let Alert_WorksheetSuccess = "Worksheets submitted successfully"
let Alert_HomeWorkSuccess = "Homework updated successfully"
let Alert_EmptyExamType = "Select exam type to proceed"
let Alert_EmptyExamDate = "Select exam date to proceed"
let Alert_NoSuggestions = "You don't have any suggestions to see"
let Alert_NoComplaints = "You don't have any complaints to see"
let Alert_NoPD_Tutorial = "No content available for you"
let Alert_Empty_Payments = "No payments data avialable"
let Alert_Empty_feeType = "Select fee type to proceed"
let Alert_Confirm_LogOut = "Do you want to logout?"
let Alert_HW_PastDate = "You can not add homework for past date"

let ALert_Tutorial_success = "Thank you! your tutorial content has been sent for review"
let ALert_PD_Success = "Thank you! your personality development content has been sent for review"
let Alert_No_Payment_Receipt = "Payment receipt not available"
