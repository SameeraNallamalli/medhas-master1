//
//  CalendarViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 05/03/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit
import FSCalendar

struct events {
    let date : String?
    let reason : String?
}

class CalendarViewController: UIViewController {
    @IBOutlet weak var vwCalendar: FSCalendar!
    @IBOutlet weak var tblEvents: UITableView!
    @IBOutlet weak var lblSelectedDate: UILabel!
    
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
    }
    var presentDates = [""]
    var leaveDates = [""]
    var holidayDates = [""]
    
    var arrTotalHolidayDict = [CommonDetails]()
    
    var arrSelectDateHolidayDict = [CommonDetails]()
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var arrEvents = [events]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addGradientBGColor()
        self.calendarAppearance()
        self.tblEvents.addAppearanceWith(isHide: false)
        self.lblSelectedDate.isHidden = true
        
        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: vwCalendar.currentPage)
        let CURRENT_YEAR = values.year!
        let CURRENT_MONTH = values.month!

        let range = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: self.vwCalendar.currentPage)
        let TOTAL_DAYS = range!.count
        
        self.getHolidayAndEventDates(year: CURRENT_YEAR, month: CURRENT_MONTH, inDays: TOTAL_DAYS)
        
        
    }
    
    func calendarAppearance()
    {
        vwCalendar.register(FSCalendarCell.self, forCellReuseIdentifier: "Cell")
        vwCalendar.scope = .month
        //  myCalender.calendarHeaderView.isHidden = true
        vwCalendar.allowsMultipleSelection = false
        vwCalendar.backgroundColor = ColorsConfig.BGColor_Grey
        vwCalendar.layer.cornerRadius = 10
        vwCalendar.clipsToBounds = true
        
        vwCalendar.firstWeekday = 2
        vwCalendar.appearance.weekdayTextColor = #colorLiteral(red: 0.05410773307, green: 0.5791940689, blue: 0.3160960476, alpha: 1)
        vwCalendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18)
        vwCalendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 14)
        vwCalendar.appearance.headerTitleColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        vwCalendar.appearance.titleFont = UIFont.boldSystemFont(ofSize: 14)
        vwCalendar.appearance.todayColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
    }

    func getHolidayAndEventDates(year:Int,month:Int,inDays:Int)
    {
        
        let paramsDict = ["month":month, "year":year,"student_id":userDetails[0].id ?? 0] as [String : Any]
        
        CommonObject().getDataFromServer(urlString: getHolidays, method: .POST, model: Holidays.self, paramsDict: paramsDict) { (data, resp, err) in
            
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
    
    func filteredJson(attendanceJson:Holidays)
    {
        presentDates.removeAll()
        holidayDates.removeAll()
        leaveDates.removeAll()
        tblEvents.isHidden = false
        
       // let detailsDict = attendanceJson.details
                
//        guard let arrDaysPresent = detailsDict?.days_present else { return }
//
//        for dayDict in arrDaysPresent
//        {
//            presentDates.append(dayDict.date!)
//        }
//
//        guard let arrDaysLeaves = detailsDict?.days_leaves else {
//            return
//        }
//
//        for dayDict in arrDaysLeaves
//        {
//            leaveDates.append(dayDict.date!)
//        }
        
        guard let arrDaysHoliday = attendanceJson.details else {
            return
        }
        
        arrTotalHolidayDict = arrDaysHoliday
        
        for dayDict in arrDaysHoliday
        {
            holidayDates.append(dayDict.date!)
        }
        vwCalendar.reloadData()
        CommonObject().dismisHUD()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CalendarViewController : FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance
{
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "Ganesh"
//    }
    
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//
//        return "Holi"
//    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        
        let cell = calendar.dequeueReusableCell(withIdentifier: "Cell", for: date, at: position)
        
        cell.backgroundColor = .clear
        
        

        return cell
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        
        let today = CommonObject().getFormattedDate(date: Date(), format: "yyyy-MM-dd")
        let dateString = self.dateFormatter2.string(from: date)
        
        if self.holidayDates.contains(dateString)
        {
            return ColorsConfig.colorHoliday
        }
        else if dateString == today
        {
            return UIColor.orange
        }
        
        return .clear
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        
        let dateString = self.dateFormatter2.string(from: date)
    

//        if self.presentDates.contains(dateString) {
//            return ColorsConfig.colorPresent
//        }
//        if self.absentDates.contains(dateString) {
//            return ColorsConfig.colorAbsent
//        }
//        if self.leaveDates.contains(dateString) {
//            return ColorsConfig.colorLeave
//        }
        if self.holidayDates.contains(dateString) {
            return ColorsConfig.colorHoliday
        }
        
        
        
        return .clear
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
         
        let dateString = self.dateFormatter2.string(from: date)
        
        let selectedDate = CommonObject().getFormattedDate(date: date, format: "EEEE, MMM d, yyyy")
        
      //  lblSelectedDate.isHidden = false
        lblSelectedDate.text = selectedDate
        
        arrSelectDateHolidayDict = arrTotalHolidayDict.filter({$0.date == dateString})
        
        tblEvents.isHidden = false
        tblEvents.reloadData()
        
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar)
    {
        CommonObject().showHUD()
        
        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: calendar.currentPage)
        let CURRENT_YEAR = values.year!
        let CURRENT_MONTH = values.month!
        
        let range = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: calendar.currentPage)
        let TOTAL_DAYS = range!.count
        
        self.getHolidayAndEventDates(year: CURRENT_YEAR, month: CURRENT_MONTH, inDays: TOTAL_DAYS)
    }
}

extension CalendarViewController : UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSelectDateHolidayDict.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCell")
        
       
        cell?.textLabel?.text = ""
        cell?.backgroundColor = .clear
        cell?.layer.cornerRadius = 8
        cell?.clipsToBounds = true

        let event = arrSelectDateHolidayDict[indexPath.section]
        if event.title != ""
        {
            cell?.textLabel?.text = event.title
            cell?.textLabel?.textColor = .white
            cell?.backgroundColor = ColorsConfig.BGColor_Grey
        }

        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
