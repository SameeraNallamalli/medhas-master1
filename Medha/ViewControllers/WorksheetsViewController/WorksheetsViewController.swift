//
//  WorksheetsViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 04/02/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit

class WorksheetsViewController: UIViewController {
    
    @IBOutlet weak var btnNewUpload: UIBarButtonItem!
    @IBOutlet weak var btnClass: UIButton!
    @IBOutlet weak var tblClass: UITableView!
    @IBOutlet weak var btnSection: UIButton!
    @IBOutlet weak var tblSection: UITableView!
    @IBOutlet weak var tblSubject: UITableView!
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var btnSubject: UIButton!
    @IBOutlet weak var stackLblHeadings: UIStackView!
    @IBOutlet weak var tblWorksheets: UITableView!
    
    var arrSubjects = [TeacherHandled]()
    var arrSubjects_Student = [defaultList]()
    var arrClassList = [TeacherHandled]()
    var arrSectionList = [TeacherHandled]()
    var arrTeacherList = [CommonDetails]()
    
    var strSelectedSub = ""
    var strSelectedClass = ""
    var strSelectedSection = ""
    var strSelectedTeacher = ""
    
    var idSelectedSub = 0
    var idSelectedClass = 0
    var idSelectedSection = 0
    
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
         
    }
    
    var arrWorksheets = [CommonDetails]()
    var arrSubClassHandled = [SubClassHandled]()
    
    @IBOutlet weak var classHConstraint: NSLayoutConstraint!
    @IBOutlet weak var sectionHConstraint: NSLayoutConstraint!
    @IBOutlet weak var subjectHConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addGradientBGColor()
        self.btnNewUpload.tintColor = UIColor.systemBlue
        
        self.btnClass.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        self.btnSection.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        self.btnSubject.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        self.btnView.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        
        self.tblClass.addAppearanceWith(isHide: true)
        self.tblSection.addAppearanceWith(isHide: true)
        self.tblSubject.addAppearanceWith(isHide: true)
        self.tblWorksheets.addAppearanceWith(isHide: false)
        
        self.tblWorksheets.alpha = 0.0
        self.tblWorksheets.estimatedRowHeight = 60
        self.tblWorksheets.rowHeight = UITableView.automaticDimension
        self.stackLblHeadings.addBorderWith(borders: [.Bottom], BGColor: .clear, borderColor: .orange)
        
        self.stackLblHeadings.isHidden = true
        
        
        if userDetails[0].roles == Role.Student_Parent.rawValue
        {
            self.navigationItem.rightBarButtonItem = nil
            self.btnClass.isHidden = true
            self.btnSection.isHidden = true
            
            strSelectedClass = userDetails[0].class_education ?? ""
            idSelectedClass = Int(userDetails[0].class_education ?? "0") ?? 0
            
            strSelectedSection = userDetails[0].section ?? ""
            idSelectedSection = Int(userDetails[0].section ?? "0") ?? 0
            
        }
        else
        {
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (self.tblClass.contentSize.height < classHConstraint.constant)
        {
             classHConstraint.constant = self.tblClass.contentSize.height
        }
        
        if (self.tblSection.contentSize.height < sectionHConstraint.constant)
        {
             sectionHConstraint.constant = self.tblSection.contentSize.height
        }
        
        if (self.tblSubject.contentSize.height < subjectHConstraint.constant)
        {
             subjectHConstraint.constant = self.tblSubject.contentSize.height
        }
        
    }
    
    func getWorksheetsData()
    {
        
        if strSelectedClass != "" && strSelectedSection != "" && strSelectedSub != ""
        {
            let parmsDict = ["class":idSelectedClass,"section":idSelectedSection, "subject":idSelectedSub] as [String : Any]

            CommonObject().getDataFromServer(urlString: getWorkSheetDetails, method: .POST, model: CommonResponceModel.self, paramsDict: parmsDict) { (data, resp, err) in
                     
                     if err == nil && resp != nil
                     {
                         print(data!)
                     
                         if data?.status == "error"
                         {
                             DispatchQueue.main.async {
                              
                                 AlertView.shared.showAlert(message: data?.msg ?? Alert_Invaid_ID_Pass, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                                 
                             }

                         }
                         else if data?.status == "success"
                         {
                           // Do with data
                           
                            if data?.details?.count ?? 0 > 0
                            {
                                DispatchQueue.main.async {
                                    self.arrWorksheets = data?.details ?? []
                                    UIView.animate(withDuration: 0.5) {
                                        self.tblWorksheets.alpha = 1.0
                                        self.tblWorksheets.reloadData()
                                        self.stackLblHeadings.isHidden = false
                                    
                                    }
                                }
                            }
                            else
                            {
                                 DispatchQueue.main.async {
                                    AlertView.shared.showAlert(message:Alert_NoWorksheets, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                                    UIView.animate(withDuration: 0.5) {
                                        self.tblWorksheets.alpha = 0.0
                                        self.stackLblHeadings.isHidden = true
                                    }
                                }
                            }

                         }
                        
                          CommonObject().dismisHUD()
                         
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
            else
            {
                errorMsg = Alert_EmptySlectedSubject
            }
            
            AlertView.shared.showAlert(message: errorMsg, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            CommonObject().dismisHUD()
        }
        
    }
    
    //MARK: - UIbutton Actions
    //MARK: -
    
    @IBAction func btnNewuploadClicked(_ sender: UIBarButtonItem)
    {
        
        let newUploadVC = MainSB.instantiateViewController(withIdentifier: "WorksheetsUploadViewController") as! WorksheetsUploadViewController
        newUploadVC.userData = userData
        /*
        newUploadVC.arrClassList = arrClassList
        newUploadVC.arrSubjects = arrSubjects
        newUploadVC.arrSectionList = arrSectionList
         */
        let navController = UINavigationController(rootViewController: newUploadVC)
        self.present(navController, animated: true, completion: nil)
        
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
        
        btnSubject.setTitle("Select Subject", for: .normal)
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
        
        btnSubject.setTitle("Select Subject", for: .normal)

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
    @IBAction func btnViewClicked(_ sender: UIButton)
    {
        arrWorksheets.removeAll()
        CommonObject().showHUD()
        self.getWorksheetsData()
        
    }
    
    @objc func btnUploadViewClickedsender(sender:UIButton)
    {
        let urlwithOutSpaces = arrWorksheets[sender.tag].upload_document?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let url = urlwithOutSpaces else { return }
        
        if UIApplication.shared.canOpenURL(URL(string: url)!)
        {
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        }
        
    }
    
}
extension WorksheetsViewController : UITableViewDelegate,UITableViewDataSource
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
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                return arrSubjects_Student.count
            }
            else
            {
               return arrSubjects.count
            }
            
        }
        else  if tableView == tblSection
        {
            return arrSectionList.count
        }
        else  if tableView == tblClass
        {
            return arrClassList.count
        }
        else
        {
            return arrWorksheets.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblSubject
        {
            let cell = tblSubject.dequeueReusableCell(withIdentifier: "SubCell")

            
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                cell?.textLabel?.text = arrSubjects_Student[indexPath.row].name
            }
            else
            {
               cell?.textLabel?.text = arrSubjects[indexPath.row].name
            }
            
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
        else
        {
            let cell = tblWorksheets.dequeueReusableCell(withIdentifier: "WorksheetsTableViewCell") as? WorksheetsTableViewCell

            cell?.backgroundColor = .clear
            
            cell?.lblSubmussionDate.text = arrWorksheets[indexPath.row].date?.toDate(Format: DF_dd_MM_yyyy)
            cell?.lblMarks.text = "\(arrWorksheets[indexPath.row].marks ?? 0)"
            cell?.lblView.text = arrWorksheets[indexPath.row].fullname
            
            if arrWorksheets[indexPath.row].upload_document?.count ?? 0 > 0
            {
                cell?.btnUploadView.setTitle("Open", for: .normal)
                cell?.btnUploadView.tag = indexPath.row
                cell?.btnUploadView.addTarget(self, action: #selector(btnUploadViewClickedsender(sender:)), for: .touchUpInside)

            }
            else
            {
                cell?.btnUploadView.setTitle("", for: .normal)

            }
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == tblSubject
        {
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                self.btnSubject.setTitle(arrSubjects_Student[indexPath.row].name, for: .normal)
                
                self.strSelectedSub = arrSubjects_Student[indexPath.row].name!
                self.idSelectedSub = arrSubjects_Student[indexPath.row].id!
            }
            else
            {
                self.btnSubject.setTitle(arrSubjects[indexPath.row].name, for: .normal)
                
                self.strSelectedSub = arrSubjects[indexPath.row].name!
                self.idSelectedSub = arrSubjects[indexPath.row].id!
            }
            

                                    
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
        else
        {
            
            
//            self.btnSection.setTitle(arrTeacherList[indexPath.row].fullname, for: .normal)
//
//            self.strSelectedTeacher = arrTeacherList[indexPath.row].fullname!
//
//            UIView.animate(withDuration: 0.3) {
//
//                self.tblSection.isHidden = true
//            }
//
//            self.tblSection.reloadData()
            
        }
        
    }
}
