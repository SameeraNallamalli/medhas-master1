//
//  PDViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 28/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit

class PDViewController: UIViewController {

    @IBOutlet weak var btnSelectCategory: UIButton!
    @IBOutlet weak var tblCategory: UITableView!
    @IBOutlet weak var btnSelectSubCategory: UIButton!
    @IBOutlet weak var tblSubCategory: UITableView!
    @IBOutlet weak var fieldContentHeading: UITextField!
    @IBOutlet weak var fieldLink: UITextField!
    @IBOutlet weak var txtViewContent: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var stackFieldsHide: UIStackView!
    
    var arrPDTypes = [defaultList]()
    var arrPDSubTypes = [SubcategoryList]()

    var strSelectedCategory = ""
    var selectedCategoryID = 0
    
    var strSelectedSubCategory = ""
    var selectedSubCategoryID = 0

    var arrPDData = [PDDetails]()
    
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
         
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addGradientBGColor()
        
        self.btnSelectCategory.addColors(titleColor: .white, bgColor: .clear, borderColor: ColorsConfig.footerColor.withAlphaComponent(0.7))
        self.btnSelectSubCategory.addColors(titleColor: .white, bgColor: .clear, borderColor: ColorsConfig.footerColor.withAlphaComponent(0.7))

        tblCategory.addAppearanceWith(isHide: true)
        tblSubCategory.addAppearanceWith(isHide: true)
        
        self.fieldContentHeading.addBorder()
        self.fieldLink.addBorder()
        
       // self.fieldLink.addDoneButtonOnKeyboard()
      //  self.fieldContentHeading.addDoneButtonOnKeyboard()
        
       // self.txtViewContent.addDoneButtonOnKeyboard()
        self.txtViewContent.addBorder()
        
        self.btnSubmit.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    @IBAction func btnSelectCateClicked(_ sender: UIButton)
    {
        if !(tblSubCategory.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubCategory.isHidden = true
            }
        }
        
        if tblCategory.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblCategory.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblCategory.isHidden = true
            }
        }
    }
    @IBAction func btnSelectSubCateClicked(_ sender: UIButton)
    {
        if strSelectedCategory == ""
        {
            AlertView.shared.showAlert(message: "Select Category first", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
        }
        else
        {
            if !(tblCategory.isHidden)
            {
                UIView.animate(withDuration: 0.3) {
                    
                    self.tblCategory.isHidden = true
                }
            }
            
            if tblSubCategory.isHidden
            {
                UIView.animate(withDuration: 0.3) {
                    
                    self.tblSubCategory.isHidden = false
                }
            }
            else
            {
                UIView.animate(withDuration: 0.3) {
                    
                    self.tblSubCategory.isHidden = true
                }
            }
        }
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton)
    {
       CommonObject().showHUD()
        if selectedCategoryID != 0 && selectedSubCategoryID != 0 && txtViewContent.text.count > 0
        {
            let parmsDict = ["category":selectedCategoryID,"sub_category":selectedSubCategoryID,"content_heading":fieldContentHeading.text!, "submitted_id":userDetails[0].id!,"content": txtViewContent.text!,"content_link":fieldLink.text!] as [String : Any]

            CommonObject().getDataFromServer(urlString: postPD, method: .POST, model: PDData.self, paramsDict: parmsDict) { (data, resp, err) in
              
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

                          AlertView.shared.showAlert(message: ALert_PD_Success, toView: self, ButtonTitles: ["OK"], ButtonActions: [
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
            
            if selectedCategoryID == 0
            {
                errorMsg = Alert_Empty_Category
            }
            else if selectedSubCategoryID == 0
            {
                errorMsg = Alert_Empty_SubCategory
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

//     // MARK: - Navigation
//
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//         if segue.identifier == segue_TutorialDetails
//         {
//            let tutorialDetailsVC = segue.destination as! TutorialDetailsViewController
//         }
//     }


}
extension PDViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblCategory
        {
            return arrPDTypes.count
        }
        else if tableView == tblSubCategory
        {
            return arrPDSubTypes.count
        }
        else
        {
            return 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblCategory
        {
            let cell = tblCategory.dequeueReusableCell(withIdentifier: "PDCategoryCell")

            cell?.textLabel?.text = arrPDTypes[indexPath.row].name
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
        else 
        {
            let cell = tblSubCategory.dequeueReusableCell(withIdentifier: "PDSubCategoryCell")

            cell?.textLabel?.text = arrPDSubTypes[indexPath.row].name
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
            
            if cell?.textLabel?.text == strSelectedSubCategory
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
        
        if tableView == tblCategory
        {
            self.btnSelectCategory.setTitle(arrPDTypes[indexPath.row].name, for: .normal)
            
            self.strSelectedCategory = arrPDTypes[indexPath.row].name!
            self.selectedCategoryID = arrPDTypes[indexPath.row].id!
            self.arrPDSubTypes = arrPDTypes[indexPath.row].sub_category!
            
            UIView.animate(withDuration: 0.3) {
                
                self.tblCategory.isHidden = true
            }
            self.tblCategory.reloadData()
            self.tblSubCategory.reloadData()
            
        }
        else if tableView == tblSubCategory
        {
            self.btnSelectSubCategory.setTitle(arrPDSubTypes[indexPath.row].name, for: .normal)
            
            self.strSelectedSubCategory = arrPDSubTypes[indexPath.row].name!
            self.selectedSubCategoryID = arrPDSubTypes[indexPath.row].id ?? 0
            
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubCategory.isHidden = true
            }
            
            self.tblSubCategory.reloadData()
        }
        else
        {
            self.performSegue(withIdentifier: segue_TutorialDetails, sender: indexPath.row)
        }

    }
    
}

extension PDViewController : UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.navigationController?.navigationBar.backgroundColor = ColorsConfig.navigationBarColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.navigationController?.navigationBar.backgroundColor = .clear

    }
    
}

