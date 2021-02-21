//
//  updateAttendanceViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 17/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit

struct TeacherHandled {
    var name : String?
    var id : Int?
}


class updateAttendanceViewController: UIViewController {
    
    @IBOutlet weak var btnSelectClass: UIButton!
    @IBOutlet weak var tblClassList: UITableView!
    @IBOutlet weak var btnSelectSection: UIButton!
    @IBOutlet weak var tblSectionsList: UITableView!
    @IBOutlet weak var btnSubject: UIButton!
    @IBOutlet weak var tblSubjectsList: UITableView!
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var searchRollNumber: UISearchBar!
    @IBOutlet weak var searchStudentName: UISearchBar!
    @IBOutlet weak var searchStatus: UISearchBar!
    @IBOutlet weak var tblStudentList: UITableView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var stackHeadings: UIStackView!
    @IBOutlet weak var stackSearchBar: UIStackView!
    @IBOutlet weak var stackSubject: UIStackView!
    
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
         
    }
    
    var arrSubjects = [TeacherHandled]()
    var arrSection = [TeacherHandled]()
    var arrClasses = [TeacherHandled]()
    
    var arrSearchFiltered = [StudentDetails]()
    
    var strSelectedSub = ""
    var strSelectedSection = ""
    var strSelectedClass = ""
    var idSelectedSub = 0
    var idSelectedSection = 0
    var idSelectedClass = 0
    var arrRollNumbers = [1,2,3,4,5,6,7,8]
    var arrPresentStatusIDs = [Int]()
    var arrAbsentStatusIDs = [Int]()
    var arrStudentsList = [StudentDetails]()
    var arrSubClassHandled = [SubClassHandled]()
    
    @IBOutlet weak var classHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sectionHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Update Attendance"
        self.addGradientBGColor()
        
        self.tblClassList.addAppearanceWith(isHide: true)
        self.tblSectionsList.addAppearanceWith(isHide: true)
        self.tblSubjectsList.addAppearanceWith(isHide: true)
        self.tblStudentList.addAppearanceWith(isHide: true)
        
        self.tblStudentList.register(UpdateAttendanceCell.self, forCellReuseIdentifier: "StudentListCell")
        
        self.searchBarAppearance()
        self.buttonAppearances()
        self.showStudentTable(show: true)
        btnSubject.isHidden = true
        stackSubject.isHidden = true
        
        arrSubClassHandled = userDetails[0].subj_class_handled!
        
        for subSecion in arrSubClassHandled
        {
            let subInfo = TeacherHandled(name: subSecion.subject_name, id: Int(subSecion.subject_id!))
            arrSubjects.append(subInfo)
            
            let classInfo = TeacherHandled(name: subSecion.class_name, id: Int(subSecion.class_id!))
            arrClasses.append(classInfo)
                        
            let sectionInfo = TeacherHandled(name: subSecion.section_name, id: Int(subSecion.section_id!))
            arrSection.append(sectionInfo)
            
        }
        
        arrSubjects = arrSubjects.uniqueValues(value: {$0.id!})
        arrClasses = arrClasses.uniqueValues(value: {$0.id!})
        arrSection = arrSection.uniqueValues(value: {$0.id!})
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (self.tblClassList.contentSize.height < classHeightConstraint.constant)
        {
             classHeightConstraint.constant = self.tblClassList.contentSize.height
        }
        
        if (self.tblSectionsList.contentSize.height < sectionHeightConstraint.constant)
        {
             sectionHeightConstraint.constant = self.tblSectionsList.contentSize.height
        }
                
    }
    
    func searchBarAppearance()
    {
        searchRollNumber.textField?.font = .systemFont(ofSize: 11)
        searchRollNumber.textField?.backgroundColor = ColorsConfig.selctionBGColor
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white], for: .normal)

    }
    func buttonAppearances()
    {
        self.btnSelectClass.addColors(titleColor: UIColor.white, bgColor: .clear, borderColor: .white)
        self.btnSelectSection.addColors(titleColor: UIColor.white, bgColor: .clear, borderColor: .white)
        self.btnSubject.addColors(titleColor: UIColor.white, bgColor: .clear, borderColor: .white)
        self.btnView.addColors(titleColor: UIColor.white, bgColor: .clear, borderColor: .white)
        self.btnSubmit.addColors(titleColor: UIColor.white, bgColor: .clear, borderColor: .white)
    }
    
    
    //MARK: -  All button action using tag number
    // tag 1 - btn Class
    // tag 2 - btn Section
    // tag 3 - btn Subject
    // tag 4 - btn View
    // tag 5 - btn Submit
    
    @IBAction func AllButtonActions(_ sender: UIButton)
    {
        switch sender.tag {
        case 1:
            self.btnClassClicked()
        case 2:
            self.btnSectionClicked()
        case 3:
            self.btnSubjectClicked()
        case 4:
            self.btnViewClicked()
        case 5:
            self.btnSubmitClicked()
        default:
            break
        }
        
        
    }
    
    func btnClassClicked()
    {
        
        if !(tblSubjectsList.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubjectsList.isHidden = true
            }
        }
        
        if tblClassList.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClassList.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClassList.isHidden = true
            }
        }
         self.tblClassList.reloadData()
        
    }
    func btnSectionClicked()
    {
        if !(tblClassList.isHidden)
        {
            UIView.animate(withDuration: 0.3) {

                self.tblClassList.isHidden = true
            }
        }
        if !(tblSubjectsList.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubjectsList.isHidden = true
            }
        }
        
        if tblSectionsList.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSectionsList.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSectionsList.isHidden = true
            }
        }
        
         self.tblSectionsList.reloadData()
    }
    func btnSubjectClicked()
    {
        if !(tblClassList.isHidden)
         {
             UIView.animate(withDuration: 0.3) {
                 
                 self.tblClassList.isHidden = true
             }
         }
         if !(tblSectionsList.isHidden)
         {
             UIView.animate(withDuration: 0.3) {
                 
                 self.tblSectionsList.isHidden = true
             }
         }
         
         if tblSubjectsList.isHidden
         {
             UIView.animate(withDuration: 0.3) {
                 
                 self.tblSubjectsList.isHidden = false
             }
         }
         else
         {
             UIView.animate(withDuration: 0.3) {
                 
                 self.tblSubjectsList.isHidden = true
             }
         }
         
          self.tblSubjectsList.reloadData()
    }
    func btnViewClicked()
    {
        if strSelectedClass != "" && strSelectedSection != ""
        {
            UIView.animate(withDuration: 0.3) {
                
                CommonObject().showHUD()
                
                self.getStudentsList()
               
            }
        }
        else
        {
            if strSelectedClass == ""
            {
                AlertView.shared.showAlert(message: Alert_EmptySlectedClass, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            }
            else if strSelectedSection == ""
            {
                AlertView.shared.showAlert(message: Alert_EmptySlectedSection, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            }
            else
            {
                AlertView.shared.showAlert(message: Alert_EmptySlectedSubject, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            }
        }

    }
    
    func getStudentsList()
    {
        let parmsDict = ["teacher_id":userDetails[0].id ?? 0   ,"class":idSelectedClass,"section":idSelectedSection,"date":CommonObject().getFormattedDate(date: Date(), format: "yyyy-MM-dd")] as [String : Any]

        CommonObject().getDataFromServer(urlString: getStudentsByClass, method: .POST, model: StudentsListByClass.self, paramsDict: parmsDict) { (data, resp, err) in
          
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
                     self.showStudentTable(show: true)
                    
                    
                    if data?.details?.count ?? 0 > 0
                    {
                        self.arrStudentsList = data?.details ?? []
                        self.arrSearchFiltered = self.arrStudentsList
                        self.showStudentTable(show: false)
                        self.tblStudentList.reloadData()
                        
                    }
                    else
                    {
                        AlertView.shared.showAlert(message: Alert_Empty_StudentList, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
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
    
    func btnSubmitClicked()
    {
      //  arrPresentStatusIDs.removeAll()
         CommonObject().showHUD()
        if arrAbsentStatusIDs.count == 0
        {
            AlertView.shared.showAlert(message: Alert_Full_Attendance, toView: self, ButtonTitles: ["YES","NO"], ButtonActions: [
                {yesAction in
                    
                    for studentDict in self.arrStudentsList
                    {
                        self.arrPresentStatusIDs.append(studentDict.id ?? 0)
                    }
                    
                    self.SendStudentAttendance(absentArray: self.arrAbsentStatusIDs, presentArray: self.arrPresentStatusIDs)
                    
                    
                },nil])
            CommonObject().dismisHUD()
        }
        else
        {
            
            for id in arrAbsentStatusIDs
            {
                arrStudentsList = arrStudentsList.filter({$0.id != id})
            }
            
            for studentDict in arrStudentsList
            {
                arrPresentStatusIDs.append(studentDict.id ?? 0)
            }
                        
            self.SendStudentAttendance(absentArray: arrAbsentStatusIDs, presentArray: arrPresentStatusIDs)
            
        }
        
    }
    
    func SendStudentAttendance(absentArray:[Int],presentArray:[Int])
    {
       
        let parmsDict = ["teacher_id":userDetails[0].id ?? 0,"date":CommonObject().getFormattedDate(date: Date(), format: "yyyy-MM-dd"),"absent_student_ids":absentArray,"present_student_ids":presentArray,"class":idSelectedClass,"section":idSelectedSection] as [String : Any]
        
        CommonObject().getDataFromServer(urlString: addAbsentees, method: .POST, model: Success_Error.self, paramsDict: parmsDict) { (data, resp, err) in
            
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
                        
                      AlertView.shared.showAlert(message: Alert_Success_Attendance, toView: self, ButtonTitles: ["OK"], ButtonActions: [{ OKClicked in
                            
                        let _ = self.navigationController?.popViewController(animated: true)
                            
                        },nil])
                        
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
    
    func showStudentTable(show:Bool)
    {
        self.stackHeadings.isHidden = show
        self.stackSearchBar.isHidden = show
        self.tblStudentList.isHidden = show
        self.btnSubmit.isHidden = show
    }
    
    @objc func switchChanged(sender:UISwitch)
    {
        
        if sender.isOn == false
        {
            if arrAbsentStatusIDs.count == 0
            {
                arrAbsentStatusIDs.append(sender.tag)
            }
            else
            {
                if !(arrAbsentStatusIDs.contains(sender.tag))
                {
                   arrAbsentStatusIDs.append(sender.tag)
                }
            }

        }
        else
        {
            if arrAbsentStatusIDs.count > 0
            {
                arrAbsentStatusIDs = arrAbsentStatusIDs.filter({$0 != sender.tag})
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
extension updateAttendanceViewController : UITableViewDelegate,UITableViewDataSource
{
   // StudentListCell
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblSubjectsList
        {
            return arrSubjects.count
        }
        else if tableView == tblClassList
        {
            return arrClasses.count
        }
        else if tableView == tblSectionsList
        {
            return arrSection.count
        }
        else
        {
             return arrSearchFiltered.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       var CellIdentifier = ""
        
        if tableView == tblClassList
        {
           CellIdentifier =  "ClassCell"
        }
        else if tableView == tblSubjectsList
        {
           CellIdentifier = "SubjectsCell"
        }
        else if tableView == tblSectionsList
        {
            CellIdentifier = "SectionCell"
        }
        else if tableView == tblStudentList
        {
            CellIdentifier = "StudentListCell"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)!
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.textAlignment = .center
        
        if tableView == tblClassList
        {
            
            cell.textLabel?.text = (arrClasses[indexPath.row].name)
            if cell.textLabel?.text == strSelectedClass
            {
               // cell.accessoryType = .checkmark
                
                cell.textLabel?.backgroundColor = ColorsConfig.selctionBGColor
                cell.detailTextLabel?.text = "You Selected"
            }
            else
            {
                cell.textLabel?.backgroundColor = .clear
                cell.detailTextLabel?.text = ""
            }
        }
        else if tableView == tblSubjectsList
        {
            cell.textLabel?.text = arrSubjects[indexPath.row].name
            if cell.textLabel?.text == strSelectedSub
            {
                cell.textLabel?.backgroundColor = ColorsConfig.selctionBGColor
                cell.detailTextLabel?.text = "You Selected"
            }
            else
            {
               // cell.accessoryType = .none
                cell.textLabel?.backgroundColor = .clear
                cell.detailTextLabel?.text = ""
            }
        }
        else if tableView == tblSectionsList
        {
            cell.textLabel?.text = arrSection[indexPath.row].name
            if cell.textLabel?.text == strSelectedSection
            {
                cell.textLabel?.backgroundColor = ColorsConfig.selctionBGColor
                cell.detailTextLabel?.text = "You Selected"
            }
            else
            {
               // cell.accessoryType = .none
                cell.textLabel?.backgroundColor = .clear
                cell.detailTextLabel?.text = ""
            }
        }
        else if  tableView == tblStudentList
        {
            let StudentsCell = Bundle.main.loadNibNamed("UpdateAttendanceCell", owner: self, options: nil)?.first as! UpdateAttendanceCell
            StudentsCell.lblStudentName.textAlignment = .left
            
            StudentsCell.backgroundColor = .clear   
            
            StudentsCell.lblRollNumber.text = arrSearchFiltered[indexPath.row].register_num ?? ""
            StudentsCell.lblStudentName.text = arrSearchFiltered[indexPath.row].fullname
            StudentsCell.StatusSwitch.tag = arrSearchFiltered[indexPath.row].id!
            StudentsCell.StatusSwitch.addTarget(self, action: #selector(switchChanged(sender:)), for:.valueChanged)
            
            StudentsCell.StatusSwitch.isOn = true
            
            /*
            if arrPresentStatusIDs.count == 0
            {
                 StudentsCell.StatusSwitch.isOn = false
            }
            else
            {
                if arrPresentStatusIDs.contains(arrSearchFiltered[indexPath.row].id!)
                {
                    StudentsCell.StatusSwitch.isOn = true
                }
                else
                {
                    StudentsCell.StatusSwitch.isOn = false
                }
            }
             */
            
            return StudentsCell
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == tblClassList
        {
            self.btnSelectClass.setTitle(arrClasses[indexPath.row].name, for: .normal)
            
            self.strSelectedClass = arrClasses[indexPath.row].name!
            
            self.idSelectedClass = arrClasses[indexPath.row].id!
            
            self.tblClassList.reloadData()
            
            UIView.animate(withDuration: 0.3) {
                
                self.tblClassList.isHidden = true
            }
            
          // stackSection.isHidden = false
        }
        else if tableView == tblSubjectsList
        {
            self.btnSubject.setTitle(arrSubjects[indexPath.row].name, for: .normal)
            
            self.strSelectedSub = arrSubjects[indexPath.row].name!
            self.idSelectedSub = arrSubjects[indexPath.row].id!
            self.tblSubjectsList.reloadData()
            
            
            UIView.animate(withDuration: 0.3) {
                                
                self.tblSubjectsList.isHidden = true
                
            }
        }
        else if tableView == tblSectionsList
        {
            
            self.btnSelectSection.setTitle(arrSection[indexPath.row].name, for: .normal)
            
            self.strSelectedSection = arrSection[indexPath.row].name!
            self.idSelectedSection = arrSection[indexPath.row].id!
            self.tblSectionsList.reloadData()
            
            UIView.animate(withDuration: 0.3) {
                
                self.tblSectionsList.isHidden = true
            }
        }
    }
}
extension updateAttendanceViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
        arrSearchFiltered = arrStudentsList
        
        if searchText.isEmpty == false
        {
            arrSearchFiltered = arrStudentsList.filter({($0.fullname?.localizedCaseInsensitiveContains(searchText))!})
            
        }
        
        tblStudentList.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.searchTextField.resignFirstResponder()
    }
}
