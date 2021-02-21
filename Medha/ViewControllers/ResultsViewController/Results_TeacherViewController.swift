//
//  Results_TeacherViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 14/02/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit

class Results_TeacherViewController: UIViewController {
    
    @IBOutlet weak var btnClass: UIButton!
    @IBOutlet weak var btnSection: UIButton!
    @IBOutlet weak var btnSubject: UIButton!
    @IBOutlet weak var btnexamDetail: UIButton!
    @IBOutlet weak var btnExamDate: UIButton!
    @IBOutlet weak var btnViewMarks: UIButton!
    @IBOutlet weak var tblClass: UITableView!
    @IBOutlet weak var tblSection: UITableView!
    @IBOutlet weak var tblSubject: UITableView!
    @IBOutlet weak var tblExamDetails: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tblResults: UITableView!
    @IBOutlet weak var stackResults: UIStackView!
    
    @IBOutlet weak var tblClassHConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblSectionHConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblSubHConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblExamDetailsHConstraint: NSLayoutConstraint!
    
    
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
         
    }
    
    var arrSubjects = [TeacherHandled]()
    var arrClassList = [TeacherHandled]()
    var arrSectionList = [TeacherHandled]()
    
    var arrResults = [CommonDetails]()
    
    var strSelectedSub = ""
    var strSelectedClass = ""
    var strSelectedSection = ""
    var strSelectedExamType = ""
    var strSubmissionDate = ""
    
    var idSelectedSub = 0
    var idSelectedClass = 0
    var idSelectedSection = 0
    var idSelectedExamType = 0
    
    var arrExamTypes = [defaultList]()
    
    var arrSecuredMarks = ["80","59","90","76","80","75","93","97"]
    var arraveragesLbl = ["Total Marks","Average Percentage","Rank"]
    
     var arrSubClassHandled = [SubClassHandled]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addGradientBGColor()
        tblClass.addAppearanceWith(isHide: true, borderColor: .clear)
        tblSection.addAppearanceWith(isHide: true, borderColor: .clear)
        tblResults.addAppearanceWith(isHide: false, borderColor: .clear)
        tblSubject.addAppearanceWith(isHide: true, borderColor: .clear)
        tblExamDetails.addAppearanceWith(isHide: true, borderColor: .clear)
        
        btnClass.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        btnSection.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        btnSubject.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        btnexamDetail.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        btnExamDate.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        btnViewMarks.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        
        self.datePickerAppearance()
        
        self.stackResults.isHidden = true
        
        self.tblResults.estimatedRowHeight = 60
        
        arrSubClassHandled = userDetails[0].subj_class_handled!
        
        for subSecion in arrSubClassHandled
        {
            let subInfo = TeacherHandled(name: subSecion.subject_name, id: Int(subSecion.subject_id!))
            arrSubjects.append(subInfo)
            
            let classInfo = TeacherHandled(name: subSecion.class_name, id: Int(subSecion.class_id!))
            arrClassList.append(classInfo)
            
            let sectionInfo = TeacherHandled(name: subSecion.section_name, id: Int(subSecion.section_id!))
            arrSectionList.append(sectionInfo)
            
        }
        
        arrSubjects = arrSubjects.uniqueValues(value: {$0.id!})
        arrClassList = arrClassList.uniqueValues(value: {$0.id!})
        arrSectionList = arrSectionList.uniqueValues(value: {$0.id!})
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (self.tblClass.contentSize.height < tblClassHConstraint.constant)
        {
             tblClassHConstraint.constant = self.tblClass.contentSize.height
        }
        
        if (self.tblSection.contentSize.height < tblSectionHConstraint.constant)
        {
             tblSectionHConstraint.constant = self.tblSection.contentSize.height
        }
        
        if (self.tblSubject.contentSize.height < tblSubHConstraint.constant)
        {
             tblSubHConstraint.constant = self.tblSubject.contentSize.height
        }
        
        if (self.tblExamDetails.contentSize.height < tblExamDetailsHConstraint.constant)
        {
             tblExamDetailsHConstraint.constant = self.tblExamDetails.contentSize.height
        }
        
    }
    
    func datePickerAppearance()
    {
        self.datePicker.isHidden = true
        self.datePicker.tintColor = .white
        self.datePicker.layer.borderColor = UIColor.white.cgColor
        self.datePicker.layer.borderWidth = 0.5
        self.datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        self.datePicker.setValue(false, forKey: "highlightsToday")
    }
    
    
    @IBAction func btnClassClicked(_ sender: UIButton)
    {
        if !(tblSubject.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubject.isHidden = true
            }
        }
        
        if !(tblSection.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = true
            }
        }
        if !(tblExamDetails.isHidden)
         {
             UIView.animate(withDuration: 0.3) {
                 
                 self.tblExamDetails.isHidden = true
                 
             }
         }
        
        if tblClass.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = true
            }
        }
        
    }
    
    @IBAction func btnSectionClicked(_ sender: UIButton)
    {
        if !(tblSubject.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubject.isHidden = true
            }
        }
        
        if !(tblClass.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = true
            }
        }
        if !(tblExamDetails.isHidden)
         {
             UIView.animate(withDuration: 0.3) {
                 
                 self.tblExamDetails.isHidden = true
                 
             }
         }
        
        if tblSection.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = true
            }
        }
    }
    
    @IBAction func btnSubjectClicked(_ sender: UIButton)
    {
        if !(tblClass.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = true
                
            }
        }
        
        if !(tblSection.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = true
                
            }
        }
        if !(tblExamDetails.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblExamDetails.isHidden = true
                
            }
        }
        if tblSubject.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubject.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubject.isHidden = true
            }
        }
    }
    
    @IBAction func btnExamDetailsClicked(_ sender: UIButton)
    {
        
        if !(tblClass.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = true
                
            }
        }
        
        if !(tblSection.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = true
                
            }
        }
        if !(tblSubject.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubject.isHidden = true
                
            }
        }
        
        if tblExamDetails.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblExamDetails.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblExamDetails.isHidden = true
            }
        }
    }
    @IBAction func btnDatePickerClicked(_ sender: UIButton)
    {
        if !(tblClass.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = true
                
            }
        }
        
        if !(tblSection.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = true
                
            }
        }
        if !(tblSubject.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubject.isHidden = true
                
            }
        }
        if !(tblExamDetails.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblExamDetails.isHidden = true
                
            }
        }
        
        if self.datePicker.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                 self.datePicker.isHidden = false
            }
        }
        else
        {
            
            UIView.animate(withDuration: 0.3) {
                
                 self.datePicker.isHidden = true
            }
        }
    }
    
    @IBAction func btnViewMarksClicked(_ sender: UIButton)
    {
        if !(tblClass.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = true
                
            }
        }
        
        if !(tblSection.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = true
                
            }
        }
        if !(tblSubject.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubject.isHidden = true
                
            }
        }
        if !(tblExamDetails.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblExamDetails.isHidden = true
                
            }
        }
        if !(datePicker.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                 self.datePicker.isHidden = true
            }
        }
        
        if strSelectedClass != "" && strSelectedSection != "" && strSelectedSub != "" && strSelectedExamType != "" && strSubmissionDate != ""
        {
            print("call web service")
            
            self.getExamResults()
        }
        else
        {
            var errorMsg = ""
            
            if strSelectedClass == ""
            {
                errorMsg = Alert_EmptySlectedClass
            }
            else if strSelectedSection == ""
            {
                errorMsg = Alert_EmptySlectedSection
            }
            else if strSelectedSub == ""
            {
                errorMsg = Alert_EmptySlectedSubject
            }
            else if strSelectedExamType == ""
            {
                errorMsg = Alert_EmptyExamType
            }
            else if strSubmissionDate == ""
            {
                errorMsg = Alert_EmptyExamDate
            }
            
            AlertView.shared.showAlert(message: errorMsg, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            
            
        }
        
        // self.stackResults.isHidden = false
    }
    
    @IBAction func datePickerSelected(_ sender: UIDatePicker)
    {
        strSubmissionDate = CommonObject().getFormattedDate(date: sender.date, format: DF_yyyy_MM_DD)
        
        self.btnExamDate.setTitle(strSubmissionDate.toDate(Format: DF_dd_MM_yyyy), for: .normal)
        
    }
    
    func getExamResults()
    {
        CommonObject().showHUD()
        
        let parmsDict = ["start_date":strSubmissionDate,"end_date":strSubmissionDate,"exam_type_id":idSelectedExamType, "subject_id":idSelectedSub, "class_id":idSelectedClass, "section_id":idSelectedSection] as [String : Any]
        
        CommonObject().getDataFromServer(urlString: getResultsByClassSubject, method: .POST, model: Results.self, paramsDict: parmsDict) { (data, resp, err) in
            
            if err == nil && resp != nil
            {
                print(data!)
                if data?.status == "error"
                {
                    DispatchQueue.main.async {
                     
                        AlertView.shared.showAlert(message: data?.msg ?? "", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                        
                    }
                    CommonObject().dismisHUD()
                     
                }
                else if data?.status == "success"
                {
                    DispatchQueue.main.async {
                        if data?.details?.count ?? 0 > 0
                        {
                            self.arrResults = data?.details ?? []
                            
                            self.tblResults.reloadData()
                            self.stackResults.isHidden = false
                        }
                        else
                        {
                            DispatchQueue.main.async {
                                AlertView.shared.showAlert(message: Alert_NoResults, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                                self.stackResults.isHidden = true
                                
                            }
                        }
                    }
                    CommonObject().dismisHUD()
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
                        }
                    }
                    else
                    {
                        DispatchQueue.main.async {
                            let statusCode = resp as! HTTPURLResponse
                            AlertView.shared.showAlert(message: "Erro in network\nStatus Code :\(statusCode.statusCode)", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                        }
                    }
                     CommonObject().dismisHUD()
                }
            }
        }
            
        
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
extension Results_TeacherViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblSubject
        {
            return arrSubjects.count
        }
        else  if tableView == tblSection
        {
            return arrSectionList.count
        }
        else  if tableView == tblClass
        {
            return arrClassList.count
        }
        else if tableView == tblExamDetails
        {
            return arrExamTypes.count
        }
        else
        {
            return arrResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        if tableView == tblSubject
        {
            let cell = tblSubject.dequeueReusableCell(withIdentifier: "SubCell")

            cell?.textLabel?.text = arrSubjects[indexPath.row].name
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
            
            if cell?.textLabel?.text == strSelectedSub
            {
                cell?.accessoryType = .checkmark
                cell?.tintColor = .white
            }
            else
            {
                cell?.accessoryType = .none
            }
            
            return cell!
        }
        else if tableView == tblClass
        {
            let cell = tblClass.dequeueReusableCell(withIdentifier: "ClassCell")

            cell?.textLabel?.text = arrClassList[indexPath.row].name
            cell?.textLabel?.numberOfLines = 0
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
            cell?.textLabel?.textAlignment = .center
            
            if cell?.textLabel?.text == strSelectedClass
            {
                cell?.accessoryType = .checkmark
                cell?.tintColor = .white
            }
            else
            {
                cell?.accessoryType = .none
            }
            
            return cell!
        }
        else if tableView == tblSection
        {
            let cell = tblSection.dequeueReusableCell(withIdentifier: "SectionCell")

            cell?.textLabel?.text = arrSectionList[indexPath.row].name
            cell?.textLabel?.numberOfLines = 0
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
            cell?.textLabel?.textAlignment = .center
            
            if cell?.textLabel?.text == strSelectedSection
            {
                cell?.accessoryType = .checkmark
                cell?.tintColor = .white
            }
            else
            {
                cell?.accessoryType = .none
            }
            
            return cell!
        }
        else if tableView == tblExamDetails
        {
            let cell = tblExamDetails.dequeueReusableCell(withIdentifier: "ExamTypeCell")

            cell?.textLabel?.text = arrExamTypes[indexPath.row].name
            cell?.textLabel?.numberOfLines = 0
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
            cell?.textLabel?.textAlignment = .center
            
            if cell?.textLabel?.text == strSelectedExamType
            {
                cell?.accessoryType = .checkmark
                cell?.tintColor = .white
            }
            else
            {
                cell?.accessoryType = .none
            }
            
            return cell!
        }
        else
        {
            
            let cell = tblResults.dequeueReusableCell(withIdentifier: "ResultsTableViewCell") as! ResultsTableViewCell

            cell.backgroundColor = .clear
            cell.lblRollNumber.text = "\(arrResults[indexPath.row].student_id ?? 0)"
            cell.lblStudentName.text = arrResults[indexPath.row].student_name
          //  cell.lblSub.textColor = .white
            cell.lblMaxMarks.textColor = .white
            cell.lblSecuredMarks.textColor = .white
            cell.lblMaxMarks.text = "\(arrResults[indexPath.row].max_marks ?? 0)"
            cell.lblSecuredMarks.text = "\(arrResults[indexPath.row].secured_marks ?? 0)"
            
            return cell
        }
                
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
     {
            
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == tblSubject
        {
            self.btnSubject.setTitle(arrSubjects[indexPath.row].name, for: .normal)
            
            self.strSelectedSub = arrSubjects[indexPath.row].name!
            self.idSelectedSub = arrSubjects[indexPath.row].id!
                                    
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubject.isHidden = true
            }
            
            self.tblSubject.reloadData()
        }
        else if tableView == tblClass
        {
            self.btnClass.setTitle(arrClassList[indexPath.row].name, for: .normal)
            
            self.strSelectedClass = arrClassList[indexPath.row].name!
            self.idSelectedClass = arrClassList[indexPath.row].id!
                                    
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = true
            }
            
            self.tblClass.reloadData()
        }
        else if tableView == tblSection
        {
            self.btnSection.setTitle(arrSectionList[indexPath.row].name, for: .normal)
            
            self.strSelectedSection = arrSectionList[indexPath.row].name!
            self.idSelectedSection = arrSectionList[indexPath.row].id!
            
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = true
            }
            
            self.tblSection.reloadData()
        }
        else if tableView == tblExamDetails
        {
            self.btnexamDetail.setTitle(arrExamTypes[indexPath.row].name, for: .normal)
            
            self.strSelectedExamType = arrExamTypes[indexPath.row].name!
            self.idSelectedExamType = arrExamTypes[indexPath.row].id!
            
            UIView.animate(withDuration: 0.3) {
                
                self.tblExamDetails.isHidden = true
            }
            
            self.tblExamDetails.reloadData()
            
        }
        
    }
}
