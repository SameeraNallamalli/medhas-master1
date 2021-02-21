//
//  SubjectInfoViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 22/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit

class SubjectInfoViewController: UIViewController {
    
    @IBOutlet weak var btnSelectSubject: UIButton!
    @IBOutlet weak var tblSubejctsList: UITableView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var txtViewDesp: UITextView!
    @IBOutlet weak var btnShowData: UIButton!
    @IBOutlet weak var stackDesp: UIStackView!
    @IBOutlet weak var btnClass: UIButton!
    @IBOutlet weak var tblClassList: UITableView!
    @IBOutlet weak var btnSection: UIButton!
    @IBOutlet weak var tblSection: UITableView!
    @IBOutlet weak var btnSelectTeacher: UIButton!
    @IBOutlet weak var tblTeacherList: UITableView!
    @IBOutlet weak var stackteacher: UIStackView!    
    @IBOutlet weak var tblteacherHeightConstraint: NSLayoutConstraint!
    
    var arrSubjects = [defaultList]()
    var arrClassList = [defaultList]()
    var arrSectionList = [defaultList]()
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
    
    @IBOutlet weak var classHConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sectionHConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var subjectHConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var teacherHConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addGradientBGColor()
        self.tblClassList.addAppearanceWith(isHide: true)
        self.tblSection.addAppearanceWith(isHide: true)
        self.tblSubejctsList.addAppearanceWith(isHide: true)
        self.tblTeacherList.addAppearanceWith(isHide: true)
        
        self.btnSelectSubject.addColors(titleColor: .white, bgColor: .clear, borderColor: .white)
        self.btnClass.addColors(titleColor: .white, bgColor: .clear, borderColor: .white)
        self.btnSection.addColors(titleColor: .white, bgColor: .clear, borderColor: .white)
        self.btnShowData.addColors(titleColor: .white, bgColor: .clear, borderColor: .white)
        self.btnSelectTeacher.addColors(titleColor: .white, bgColor: .clear, borderColor: .white)
        
        txtViewDesp.backgroundColor = ColorsConfig.BGColor_Grey
        txtViewDesp.layer.cornerRadius = 10
        txtViewDesp.clipsToBounds = true
        txtViewDesp.layer.borderColor = UIColor.white.cgColor
        txtViewDesp.layer.borderWidth = 0.8
        
        self.stackDesp.alpha = 0.0
        
        txtViewDesp.text = "A teacher is a person who helps students to acquire knowledge, competence or virtue. Informally the role of teacher may be taken on by anyone. In some countries, teaching young people of school age may be carried out in an informal setting, such as within the family, rather than in a formal setting such as a school or college"
        
        img.layer.cornerRadius =  10
        img.clipsToBounds = true
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 0.8
        
        stackteacher.isHidden = true
        
        if userDetails[0].roles == Role.Student_Parent.rawValue
        {
            self.btnClass.isHidden = true
            self.btnSection.isHidden = true
            
            strSelectedClass = userDetails[0].class_education ?? ""
            idSelectedClass = Int(userDetails[0].class_education ?? "0") ?? 0
            
            strSelectedSection = userDetails[0].section ?? ""
            idSelectedSection = Int(userDetails[0].section ?? "0") ?? 0
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (self.tblClassList.contentSize.height < classHConstraint.constant)
        {
             classHConstraint.constant = self.tblClassList.contentSize.height
        }
        
        if (self.tblSection.contentSize.height < sectionHConstraint.constant)
        {
             sectionHConstraint.constant = self.tblSection.contentSize.height
        }
        
        if (self.tblSubejctsList.contentSize.height < subjectHConstraint.constant)
        {
             subjectHConstraint.constant = self.tblSubejctsList.contentSize.height
        }
        
//        if (self.tblTeacherList.contentSize.height < teacherHConstraint.constant)
//        {
//             teacherHConstraint.constant = self.tblTeacherList.contentSize.height
//        }
        
    }
        
    @IBAction func btnClassClicked(_ sender: UIButton)
    {
        if !(tblSubejctsList.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubejctsList.isHidden = true
            }
        }
        
        if !(tblSection.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = true
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
        
        strSelectedSub = ""
        btnSelectSubject.setTitle("Select Subject", for: .normal)
    }
    
    @IBAction func btnSectionClicked(_ sender: UIButton)
    {
        if !(tblSubejctsList.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubejctsList.isHidden = true
            }
        }
        
        if !(tblClassList.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClassList.isHidden = true
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
        
        strSelectedSub = ""
        btnSelectSubject.setTitle("Select Subject", for: .normal)
    }

    @IBAction func btnSelectTeacherClicked(_ sender: UIButton)
    {
        if !(tblClassList.isHidden)
         {
             UIView.animate(withDuration: 0.3) {
                 
                 self.tblClassList.isHidden = true
                 
             }
         }
         
         
         if tblTeacherList.isHidden
         {
             UIView.animate(withDuration: 0.3) {
                 
                 self.tblTeacherList.isHidden = false
             }
         }
         else
         {
             UIView.animate(withDuration: 0.3) {
                 
                 self.tblTeacherList.isHidden = true
             }
         }
    }
    
    @IBAction func btnSelectSubClicked(_ sender: UIButton)
    {
        if !(tblClassList.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClassList.isHidden = true
                
            }
        }
        
        
        if tblSubejctsList.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubejctsList.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubejctsList.isHidden = true
            }
        }
        
    }
    
    @IBAction func BtnShowDataClicked(_ sender: UIButton)
    {
        
        if strSelectedSub != "" && strSelectedClass != "" && strSelectedSection != ""
        {
            if !(tblSubejctsList.isHidden)
            {
                UIView.animate(withDuration: 0.3) {
                    
                    self.tblSubejctsList.isHidden = true
                }
            }
            
            if !(tblClassList.isHidden)
            {
                UIView.animate(withDuration: 0.3) {
                    
                    self.tblClassList.isHidden = true
                }
            }
            if !(tblSection.isHidden)
            {
                UIView.animate(withDuration: 0.3) {
                    
                    self.tblSection.isHidden = true
                }
            }
            
            CommonObject().showHUD()
            
            self.getTeacherInfo()
            
        }
        else
        {
            if strSelectedClass == ""
            {
                AlertView.shared.showAlert(message: Alert_EmptySlectedClass, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            }
            else if strSelectedSub == ""
            {
                AlertView.shared.showAlert(message: Alert_EmptySlectedSubject, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            }
            else
            {
                AlertView.shared.showAlert(message: Alert_EmptySlectedSection, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            }
        }
 
    }
    
    func getTeacherInfo()
    {
        
        let parmsDict = ["subject":idSelectedSub, "class":idSelectedClass, "section":idSelectedSection] as [String : Any]
        
        CommonObject().getDataFromServer(urlString: getSubjectInfo, method: .POST, model: SubjectInfo.self, paramsDict: parmsDict) { (data, resp, err) in
            
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
                        
                        self.stackDesp.alpha = 0
                        self.stackteacher.isHidden = true
                            
                        if data?.details?.count ?? 0 > 0
                        {
                            self.arrTeacherList = (data?.details!)!
                            
                            self.tblTeacherList.reloadData()
                            
                            self.stackteacher.isHidden = false
                            self.btnSelectTeacher.setTitle("Select Teacher Name", for: .normal)
                            
                        }
                        else
                        {
                            
                            AlertView.shared.showAlert(message: "No teachers found for your search, try another", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
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
    
    func updateTeacherInfo(details:CommonDetails)
    {
        
        img.loadImageUsingCache(withUrl: details.profile_pic ?? "")
        
        if details.profile_summary == ""
        {
            txtViewDesp.text = "Profile summary not available"
        }
        else
        {
            txtViewDesp.text = details.profile_summary
        }
        
        
        UIView.animate(withDuration: 0.3) {
            
            self.stackDesp.alpha = 1.0
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
extension SubjectInfoViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblSubejctsList
        {
            return arrSubjects.count
        }
        else  if tableView == tblSection
        {
            return arrSectionList.count
        }
        else  if tableView == tblClassList
        {
            return arrClassList.count
        }
        else
        {
            return arrTeacherList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblSubejctsList
        {
            let cell = tblSubejctsList.dequeueReusableCell(withIdentifier: "SubCell")

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
        else if tableView == tblClassList
        {
            let cell = tblClassList.dequeueReusableCell(withIdentifier: "ClassCell")

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
            let cell = tblTeacherList.dequeueReusableCell(withIdentifier: "TeacherListCell")

            cell?.textLabel?.text = arrTeacherList[indexPath.row].fullname
            cell?.textLabel?.numberOfLines = 0
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
            cell?.textLabel?.textAlignment = .center
            
            if cell?.textLabel?.text == strSelectedTeacher
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == tblSubejctsList
        {
            self.btnSelectSubject.setTitle(arrSubjects[indexPath.row].name, for: .normal)
            
            self.strSelectedSub = arrSubjects[indexPath.row].name!
            self.idSelectedSub = arrSubjects[indexPath.row].id!
                                    
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubejctsList.isHidden = true
            }
            
            self.tblSubejctsList.reloadData()
        }
        else if tableView == tblClassList
        {
            self.btnClass.setTitle(arrClassList[indexPath.row].name, for: .normal)
            
            self.strSelectedClass = arrClassList[indexPath.row].name!
            self.idSelectedClass = arrClassList[indexPath.row].id!
                                    
            UIView.animate(withDuration: 0.3) {
                
                self.tblClassList.isHidden = true
            }
            
            self.tblClassList.reloadData()
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
            self.btnSelectTeacher.setTitle(arrTeacherList[indexPath.row].fullname, for: .normal)
            
            self.strSelectedTeacher = arrTeacherList[indexPath.row].fullname!
            
            self.updateTeacherInfo(details: arrTeacherList[indexPath.row])

                                    
            UIView.animate(withDuration: 0.3) {
                
                self.tblTeacherList.isHidden = true
            }
            
            self.tblTeacherList.reloadData()
            
        }
        
    }
    
}
