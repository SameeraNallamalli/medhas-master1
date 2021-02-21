//
//  AttendanceViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 07/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit
import FSCalendar


class AttendanceViewController: UIViewController {
    
    @IBOutlet weak var myCalender: FSCalendar!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnHeaderDate: UIButton!
    @IBOutlet weak var stackPrevAndNext: UIStackView!
    @IBOutlet weak var lblPresent: UILabel!
    @IBOutlet weak var lblHolidays: UILabel!
    @IBOutlet weak var lblMonthlyPercentage: UILabel!
    @IBOutlet weak var lblLeaves: UILabel!
    @IBOutlet weak var lblTotalWorkingDays: UILabel!
    @IBOutlet weak var lblTotalPresentDays: UILabel!
    @IBOutlet weak var lblAnnualPercentage: UILabel!
    
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
         
    }
    
    var presentDates = [""]
   // var absentDates = ["2019-12-02"]
    var leaveDates = [""]
    var holidayDates = [""]
    var intTotalWorkignDays = Int()
    var intTotalPresentDays = Int()
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addGradientBGColor()
        self.calendarAppearance()
        
        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: myCalender.currentPage)
        let CURRENT_YEAR = values.year!
        let CURRENT_MONTH = values.month!

        let range = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: self.myCalender.currentPage)
        let TOTAL_DAYS = range!.count
        
        self.getRandomDates(year: CURRENT_YEAR, month: CURRENT_MONTH, inDays: TOTAL_DAYS)

        
    }
    @IBAction func btnPreviousClicked(_ sender: UIButton)
    {
        myCalender.setCurrentPage(getNextMonth(date: myCalender.currentPage), animated: true)
        
    }
    
    @IBAction func btnNextClicked(_ sender: UIButton)
    {
        myCalender.setCurrentPage(getPreviousMonth(date: myCalender.currentPage), animated: true)

    }
    
    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }

    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    func calendarAppearance()
    {
          myCalender.register(FSCalendarCell.self, forCellReuseIdentifier: "Cell")
          myCalender.scope = .month
        //  myCalender.calendarHeaderView.isHidden = true
          myCalender.allowsMultipleSelection = false
          stackPrevAndNext.isHidden = true
          myCalender.backgroundColor = .clear
        //  myCalender.appearance.borderRadius = 0
        
        myCalender.appearance.weekdayTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        myCalender.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18)
        myCalender.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 14)
        myCalender.appearance.headerTitleColor = .yellow
        myCalender.appearance.titleFont = UIFont.boldSystemFont(ofSize: 14)
        myCalender.appearance.todayColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    }
    
    func updateLabels()
    {
        
        lblPresent.attendaceLblAppearance(bgColor: ColorsConfig.colorPresent)
        lblPresent.text = "\(presentDates.count)"
        
        let present = Float(presentDates.count)
        let total = Float(30)
        let average = present/total
        let monthlyPercentage = Int(average * 100)
        
        lblMonthlyPercentage.attendaceLblAppearance(bgColor: .orange)
        lblMonthlyPercentage.text = "\(monthlyPercentage) %"
        
        lblLeaves.attendaceLblAppearance(bgColor: ColorsConfig.colorLeave)
        lblLeaves.text = "\(leaveDates.count)"
        
        lblHolidays.attendaceLblAppearance(bgColor: ColorsConfig.colorHoliday)
        lblHolidays.text = "\(holidayDates.count)"
        
        lblTotalWorkingDays.text = "\(intTotalWorkignDays)"
        lblTotalPresentDays.text = "\(intTotalPresentDays)"
        
        let TotalPresentDays = Float(intTotalPresentDays)
        let TotalWorkingDays = Float(intTotalWorkignDays)
        
        if TotalWorkingDays > 0
        {
            let totalSverage = TotalPresentDays/TotalWorkingDays
            let yearlyPercentage = Int(totalSverage * 100)
            lblAnnualPercentage.text = "\(yearlyPercentage) %"
        }
        else
        {
            lblAnnualPercentage.text = "0 %"
        }

        
        lblAnnualPercentage.attendaceLblAppearance(bgColor: .orange)
        lblTotalPresentDays.attendaceLblAppearance(bgColor: .orange)
        lblTotalWorkingDays.attendaceLblAppearance(bgColor: .orange)
        
    }
    
    func getRandomDates(year:Int,month:Int,inDays:Int)
    {
        
        let paramsDict = ["month":month, "year":year,"student_id":userDetails[0].id!] as [String : Any]
        
        CommonObject().getDataFromServer(urlString: getAttendanceByMonth, method: .POST, model: Attendance.self, paramsDict: paramsDict) { (data, resp, err) in
            
            if err == nil && resp != nil
            {
                if data?.status == "error"
                {
                    DispatchQueue.main.async {
                     
                        AlertView.shared.showAlert(message: data?.msg ?? Alert_Invaid_ID_Pass, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                        CommonObject().dismisHUD()
                        
                    }
                     
                }
                else if data?.status == "success"
                {
                    DispatchQueue.main.async {

                        self.filteredJson(attendanceJson: data!)
                        
                    }
                
                }
                
            }
            else
            {
                 if err != nil
                {
                    if resp == nil
                    {
                        DispatchQueue.main.async {

                            AlertView.shared.showAlert(message: err ?? "error in network", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                            CommonObject().dismisHUD()
                        }
                    }
                    else
                    {
                        DispatchQueue.main.async {
                            let statusCode = resp as! HTTPURLResponse
                            AlertView.shared.showAlert(message: "Erro in network\nStatus Code :\(statusCode.statusCode)", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                            CommonObject().dismisHUD()
                        }
                    }
                     
                }
            }
            
        }

    }
    
    func filteredJson(attendanceJson:Attendance)
    {
        presentDates.removeAll()
        holidayDates.removeAll()
        leaveDates.removeAll()
        
        let detailsDict = attendanceJson.details
        
        self.intTotalPresentDays = detailsDict?.total_present_days ?? 0
        self.intTotalWorkignDays =  detailsDict?.total_working_days ?? 0
        
        guard let arrDaysPresent = detailsDict?.days_present else { return }
        
        for dayDict in arrDaysPresent
        {
            presentDates.append(dayDict.date!)
        }
        
        guard let arrDaysLeaves = detailsDict?.days_leaves else {
            return
        }
        
        for dayDict in arrDaysLeaves
        {
            leaveDates.append(dayDict.date!)
        }
        
        guard let arrDaysHoliday = detailsDict?.days_holiday else {
            return
        }
        
        for dayDict in arrDaysHoliday
        {
            holidayDates.append(dayDict.date!)
        }
        
        self.updateLabels()
        myCalender.reloadData()
        CommonObject().dismisHUD()
        
    }
    
}

extension AttendanceViewController : FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance
{
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "Ganesh"
//    }
    
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//
//        return "Holi"
//    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let today = CommonObject().getFormattedDate(date: Date(), format: "yyyy-MM-dd")

        let dateString = self.dateFormatter2.string(from: date)

        if self.presentDates.contains(dateString) {
            return ColorsConfig.colorPresent
        }
        //        if self.absentDates.contains(dateString) {
        //            return ColorsConfig.colorAbsent
        //        }
        if self.leaveDates.contains(dateString) {
            return ColorsConfig.colorLeave
        }
        if self.holidayDates.contains(dateString) {
            return ColorsConfig.colorHoliday
        }
        else if dateString == today
        {
           return  UIColor.orange
        }

            return .clear
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        
        let cell = calendar.dequeueReusableCell(withIdentifier: "Cell", for: date, at: position)
        
        cell.backgroundColor = .clear
        
        

        return cell
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        
        let dateString = self.dateFormatter2.string(from: date)

        if self.presentDates.contains(dateString) {
            return ColorsConfig.colorPresent
        }
//        if self.absentDates.contains(dateString) {
//            return ColorsConfig.colorAbsent
//        }
        if self.leaveDates.contains(dateString) {
            return ColorsConfig.colorLeave
        }
        if self.holidayDates.contains(dateString) {
            return ColorsConfig.colorHoliday
        }
        
        return .clear
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar)
    {
        CommonObject().showHUD()
        
        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: calendar.currentPage)
        let CURRENT_YEAR = values.year!
        let CURRENT_MONTH = values.month!
        
        let range = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: calendar.currentPage)
        let TOTAL_DAYS = range!.count
        
        self.getRandomDates(year: CURRENT_YEAR, month: CURRENT_MONTH, inDays: TOTAL_DAYS)
    }
    
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
       // let dateString = self.dateFormatter2.string(from: date)

//        if self.datesWithEvent.contains(dateString) {
//            return 1
//        }

//        if self.datesWithMultipleEvents.contains(dateString) {
//            return 3
//        }

        return 0
        
    }
}
