//
//  ComplaintsViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 23/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit
import CoreData

class ComplaintsViewController: UIViewController {
    
    @IBOutlet weak var fieldName: UITextField!
    @IBOutlet weak var fieldClass: UITextField!
    @IBOutlet weak var btnSelectCategory: UIButton!
    @IBOutlet weak var tblCategories: UITableView!
    @IBOutlet weak var txtViewComplaintsBox: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    
    @IBOutlet weak var btnClass: UIButton!
    @IBOutlet weak var btnSection: UIButton!
    @IBOutlet weak var tblClass: UITableView!
    @IBOutlet weak var tblSection: UITableView!
    @IBOutlet weak var stackClassSection: UIStackView!
    
    var arrClassList = [TeacherHandled]()
    var arrSectionList = [TeacherHandled]()
    
    var arrComplaintsTypes = [defaultList]()
    var strSelectedCategory = ""
    var selectedCategoryID = 0
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
         
    }
    var isTblOptionSelected = false
   var strSelectedClass = ""
   var strSelectedSection = ""
   var idSelectedClass = 0
   var idSelectedSection = 0
    
    var arrSubClassHandled = [SubClassHandled]()
    
    @IBOutlet weak var classHConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sectionHConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var categoryHConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addGradientBGColor()
        //table Configuration
        self.tblCategories.addAppearanceWith(isHide: true)
        self.tblClass.addAppearanceWith(isHide: true)
        self.tblSection.addAppearanceWith(isHide: true)
        // textView Configuration
        self.txtViewComplaintsBox.addBorder()
        self.buttonsAppearance()
        self.fieldAppearance()
       // self.getComplaintsData()
      //  txtViewComplaintsBox.addDoneButtonOnKeyboard()
        
        txtViewComplaintsBox.addBorder()
        self.stackClassSection.isHidden = true
        if userDetails[0].roles == Role.Student_Parent.rawValue
        {
            self.navigationItem.rightBarButtonItem = nil
           
            
            strSelectedClass = userDetails[0].class_education ?? ""
            idSelectedClass = Int(userDetails[0].class_education ?? "0") ?? 0
            
            strSelectedSection = userDetails[0].section ?? ""
            idSelectedSection = Int(userDetails[0].section ?? "0") ?? 0
        }
        else
        {
                strSelectedClass =  ""
                idSelectedClass = -1
                
                strSelectedSection =  ""
                idSelectedSection = -1
            
//            arrSubClassHandled = userDetails[0].subj_class_handled!
//
//            for subSecion in arrSubClassHandled
//            {
//
//                let classInfo = TeacherHandled(name: subSecion.class_name, id: Int(subSecion.class_id!))
//                arrClassList.append(classInfo)
//
//                let sectionInfo = TeacherHandled(name: subSecion.section_name, id: Int(subSecion.section_id!))
//                arrSectionList.append(sectionInfo)
//
//            }
//
//            //arrSubjects = arrSubjects.uniqueValues(value: {$0.id!})
//            arrClassList = arrClassList.uniqueValues(value: {$0.id!})
//            arrSectionList = arrSectionList.uniqueValues(value: {$0.id!})
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
        
        if (self.tblCategories.contentSize.height < categoryHConstraint.constant)
        {
             categoryHConstraint.constant = self.tblCategories.contentSize.height
        }
        
    }
    
    @IBAction func btnCancelClicked(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func fieldAppearance()
    {
        guard userData != nil else {

        fieldName.placeholder = "Enter your full name"
        fieldName.textColor = .white
        fieldName.backgroundColor = .clear
        fieldName.borderStyle = .roundedRect
        fieldName.layer.borderWidth = 1
        fieldName.layer.borderColor = UIColor.black.withAlphaComponent(0.7).cgColor
        fieldName.isUserInteractionEnabled = true

        fieldClass.placeholder = "Enter your class"
        fieldClass.backgroundColor = .clear
        fieldClass.textColor = .white
        fieldClass.borderStyle = .roundedRect
        fieldClass.layer.borderWidth = 1
        fieldClass.layer.borderColor = UIColor.black.withAlphaComponent(0.7).cgColor
        fieldClass.isUserInteractionEnabled = true

        return
        }
       
        fieldName.text = userDetails[0].fullname
        fieldName.textColor = .darkGray
        fieldName.backgroundColor = .clear
        fieldName.borderStyle = .none
        fieldName.isUserInteractionEnabled = false
        
        
        fieldClass.text = userDetails[0].class_education
        fieldClass.backgroundColor = .clear
        fieldClass.textColor = .darkGray
        fieldClass.borderStyle = .none
        fieldClass.isUserInteractionEnabled = false
   
    }
    
//    func txtViewConfiguration()
//    {
//        self.txtViewComplaintsBox.backgroundColor = ColorsConfig.BGColor_Grey
//        self.txtViewComplaintsBox.layer.borderColor = UIColor.white.cgColor
//        self.txtViewComplaintsBox.layer.borderWidth = 1.5
//        self.txtViewComplaintsBox.textColor = .white
//        self.txtViewComplaintsBox.tintColor = .white
//    }
//
    func buttonsAppearance()
    {
        self.btnSelectCategory.addColors(titleColor: .white, bgColor: .clear, borderColor: ColorsConfig.footerColor.withAlphaComponent(0.7))
        self.btnSubmit.addColors(titleColor: .white, bgColor: UIColor.white.withAlphaComponent(0.5), borderColor: ColorsConfig.footerColor.withAlphaComponent(0.7))
        self.btnClass.addColors(titleColor: .white, bgColor: ColorsConfig.appColorGreen, borderColor: ColorsConfig.footerColor.withAlphaComponent(0.7))
        self.btnSection.addColors(titleColor: .white, bgColor: ColorsConfig.appColorGreen, borderColor: ColorsConfig.footerColor.withAlphaComponent(0.7))
    }
    
   func getComplaintsData()
   {
                 
       CommonObject().getDataFromServer(urlString: getComplaints, method: .GET, model: Suggestions.self, paramsDict: nil) { (data, resp, err) in
         
         if err == nil && resp != nil
         {
             print(data!)
             if data?.status == "error"
             {
                 DispatchQueue.main.async {
                  
                     AlertView.shared.showAlert(message: data?.msg ?? "", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                 }
             }
             else if data?.status == "success"
             {
               
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
    
    
    @IBAction func btnClassClicled(_ sender: UIButton)
    {
        
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
                
    }
    @IBAction func btnSectionClicked(_ sender: UIButton)
    {
        
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
    }
    @IBAction func btnSelectCategoryClicked(_ sender: UIButton)
    {
        if tblCategories.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblCategories.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblCategories.isHidden = true
            }
        }
        
    }
    @IBAction func btnSubmitClicked(_ sender: UIButton)
    {
        if txtViewComplaintsBox.text != "" && selectedCategoryID != 0 && idSelectedClass != 0 && idSelectedSection != 0
        {
           // let tktNumber = Date().millisecondsSince1970
            var parmsDict = [String :  Any]()
            
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                parmsDict = ["area":selectedCategoryID,"class":userDetails[0].class_education!,"section":userDetails[0].section!,"student_id":userDetails[0].id!,"student_name":userDetails[0].fullname!,"content":txtViewComplaintsBox.text!] as [String : Any]

            }
            else
            {
                parmsDict = ["area":selectedCategoryID,"class":idSelectedClass,"section":idSelectedSection,"student_id":userDetails[0].id!,"student_name":userDetails[0].fullname!,"content":txtViewComplaintsBox.text!] as [String : Any]

            }
          
            CommonObject().getDataFromServer(urlString: postComplaint, method: .POST, model: Suggestions.self, paramsDict: parmsDict) { (data, resp, err) in
              
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
                        AlertView.shared.showAlert(message: Alert_Complaint_Success, toView: self, ButtonTitles: ["OK"], ButtonActions: [
                            { okClicked in
                            
                                if self.userDetails[0].roles == Role.Student_Parent.rawValue
                                {
                                    self.navigationController?.popViewController(animated: true)
                                }
                                else
                                {
                                    self.dismiss(animated: true, completion: nil)
                                }
                            
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
        else
        {
            if idSelectedClass == 0
            {
                AlertView.shared.showAlert(message:Alert_EmptySlectedClass, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])

            }
            else if idSelectedSection == 0
            {
                AlertView.shared.showAlert(message:Alert_EmptySlectedSection, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])

            }
            else if selectedCategoryID == 0
            {
                AlertView.shared.showAlert(message:"Please select complaint area", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            }
            else
            {
                AlertView.shared.showAlert(message:"Please add your comments", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
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
extension ComplaintsViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblCategories
        {
            return arrComplaintsTypes.count
        }
        else  if tableView == tblSection
        {
            return arrSectionList.count
        }
        else
        {
            return arrClassList.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == tblCategories
        {
            let cell = tblCategories.dequeueReusableCell(withIdentifier: "ComplaintsCell")

            cell?.textLabel?.text = arrComplaintsTypes[indexPath.row].name
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
            
            if cell?.textLabel?.text == strSelectedCategory
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
        else
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
        

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == tblCategories
        {
            self.btnSelectCategory.setTitle(arrComplaintsTypes[indexPath.row].name, for: .normal)
            
            self.strSelectedCategory = arrComplaintsTypes[indexPath.row].name!
            self.selectedCategoryID = arrComplaintsTypes[indexPath.row].id!
            self.tblCategories.reloadData()
            
            UIView.animate(withDuration: 0.3) {
                
                self.tblCategories.isHidden = true
            }
            
            isTblOptionSelected = true
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
            
            isTblOptionSelected = true
        }
        
       
    }
    
}

