//
//  TutorialsViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 26/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit

class TutorialsViewController: UIViewController {
    
    @IBOutlet weak var btnSelectSubject: UIButton!
    @IBOutlet weak var tblSubjects: UITableView!
    @IBOutlet weak var fieldContentHeading: UITextField!
    @IBOutlet weak var fieldLink: UITextField!
    @IBOutlet weak var txtViewContent: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnSelectClass: UIButton!
    @IBOutlet weak var tblClass: UITableView!
    
    @IBOutlet weak var stackFieldsHide: UIStackView!
    @IBOutlet weak var tblSection: UITableView!
    @IBOutlet weak var btnSection: UIButton!
    
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
         
    }
    
    var arrTutorialTypes = [defaultList]()
    
    var arrClassTypes = [TeacherHandled]()
    var arrSectionTypes = [TeacherHandled]()
    var arrSubTypes = [TeacherHandled]()
    
    var strSelectedSub = ""
    var SelectedSubID = 0
    
    var strSelectedClass = ""
    var SelectedClassID = 0
    
    var strSelectedSection = ""
    var SelectedSectionID = 0
    
    var arrSubClassHandled = [SubClassHandled]()
    
    @IBOutlet weak var classHConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sectionHConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addGradientBGColor()
        
        self.btnSelectSubject.addColors(titleColor: .white, bgColor: .clear, borderColor: ColorsConfig.footerColor.withAlphaComponent(0.7))
        self.btnSelectClass.addColors(titleColor: .white, bgColor: .clear, borderColor: ColorsConfig.footerColor.withAlphaComponent(0.7))
        self.btnSection.addColors(titleColor: .white, bgColor: .clear, borderColor: ColorsConfig.footerColor.withAlphaComponent(0.7))
        
        self.tblClass.addAppearanceWith(isHide: true)
        self.tblSubjects.addAppearanceWith(isHide: true)
        self.tblSection.addAppearanceWith(isHide: true)
        
        self.fieldContentHeading.addBorder()
        self.fieldLink.addBorder()
           
     //   self.fieldLink.addDoneButtonOnKeyboard()
      //  self.fieldContentHeading.addDoneButtonOnKeyboard()
        
      //  self.txtViewContent.addDoneButtonOnKeyboard()
        self.txtViewContent.addBorder()
        
        if userDetails[0].roles != Role.Student_Parent.rawValue
        {
            self.btnSubmit.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
            
            arrSubClassHandled = userDetails[0].subj_class_handled!
            
            for subSecion in arrSubClassHandled
            {
                let subInfo = TeacherHandled(name: subSecion.subject_name, id: Int(subSecion.subject_id!))
                arrSubTypes.append(subInfo)
                
                let classInfo = TeacherHandled(name: subSecion.class_name, id: Int(subSecion.class_id!))
                arrClassTypes.append(classInfo)
                
                let sectionInfo = TeacherHandled(name: subSecion.section_name, id: Int(subSecion.section_id!))
                arrSectionTypes.append(sectionInfo)
                
            }
            
            arrSubTypes = arrSubTypes.uniqueValues(value: {$0.id!})
            arrClassTypes = arrClassTypes.uniqueValues(value: {$0.id!})
            arrSectionTypes = arrSectionTypes.uniqueValues(value: {$0.id!})
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
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    @IBAction func btnSelectSubClicked(_ sender: UIButton)
    {
        if !(tblClass.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = true
            }
        }
        
        if tblSubjects.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubjects.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubjects.isHidden = true
            }
        }
    }
    @IBAction func btnSelectClassClicked(_ sender: UIButton)
    {
        if !(tblSubjects.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubjects.isHidden = true
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
    @IBAction func btnSectionSelected(_ sender: UIButton)
    {
        if !(tblSubjects.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubjects.isHidden = true
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

        
    }
    
    
    @IBAction func btnSubmitClicked(_ sender: UIButton)
    {
        CommonObject().showHUD()
        if SelectedSubID != 0  && txtViewContent.text.count > 0
        {
            let parmsDict = ["subject":SelectedSubID,"class":SelectedClassID,"section":SelectedSectionID,"content_heading":fieldContentHeading.text!, "submitted_id":userDetails[0].id!,"content": txtViewContent.text!,"content_link":fieldLink.text!] as [String : Any]

            CommonObject().getDataFromServer(urlString: postTutorial, method: .POST, model: Success_Error.self, paramsDict: parmsDict) { (data, resp, err) in
              
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

                          AlertView.shared.showAlert(message: ALert_Tutorial_success, toView: self, ButtonTitles: ["OK"], ButtonActions: [
                              { okClicked in
                             
                                self.navigationController?.popViewController(animated: true)
                              
                              },nil]
                          )
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
            var errorMsg = ""
            
            if SelectedSubID == 0
            {
                errorMsg = Alert_Empty_Category
            }
            else
            {
                errorMsg = Alert_Empty_Comments
            }
            
            AlertView.shared.showAlert(message: errorMsg, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            CommonObject().dismisHUD()
        }
        
    }
    
    
    @objc func btnCellContentDetailsClicked(sender:UIButton)
    {
        sender.showsTouchWhenHighlighted = true
        self.performSegue(withIdentifier: segue_TutorialDetails, sender: sender.tag)
    }
    

    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segue_TutorialDetails
        {
            let tutorialDetailsVC = segue.destination as! TutorialDetailsViewController
        }
    }
 */


}
extension TutorialsViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblSubjects
        {
          return arrTutorialTypes.count
        }
        else
        {
            return arrClassTypes.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblSubjects
        {
            let cell = tblSubjects.dequeueReusableCell(withIdentifier: "tutorialSubjectCell")

            cell?.textLabel?.text = arrTutorialTypes[indexPath.row].name
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
            let cell = tblClass.dequeueReusableCell(withIdentifier: "tutorialClassCell")

            cell?.textLabel?.text = arrClassTypes[indexPath.row].name
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
            
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

            cell?.textLabel?.text = arrSectionTypes[indexPath.row].name
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
            
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
        
        if tableView == tblSubjects
        {
            self.btnSelectSubject.setTitle(arrTutorialTypes[indexPath.row].name, for: .normal)
            
            self.strSelectedSub = arrTutorialTypes[indexPath.row].name!
            self.SelectedSubID = arrTutorialTypes[indexPath.row].id!
            
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubjects.isHidden = true
            }
            
            self.tblSubjects.reloadData()
        }
        else if tableView == tblClass
        {
            self.btnSelectClass.setTitle(arrClassTypes[indexPath.row].name, for: .normal)
            
            self.strSelectedClass = arrClassTypes[indexPath.row].name!
            self.SelectedClassID = arrClassTypes[indexPath.row].id!
            
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = true
            }
            
            self.tblClass.reloadData()
        }
        else
        {
            self.btnSection.setTitle(arrSectionTypes [indexPath.row].name, for: .normal)
            
            self.strSelectedSection = arrSectionTypes[indexPath.row].name!
            self.SelectedSectionID = arrSectionTypes[indexPath.row].id!
            
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = true
            }
            
            self.tblSection.reloadData()
        }
    }
    

}
extension TutorialsViewController : UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.navigationController?.navigationBar.backgroundColor = ColorsConfig.navigationBarColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.navigationController?.navigationBar.backgroundColor = .clear

    }
    
}
