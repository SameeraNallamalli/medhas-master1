//
//  ProfileEditViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 03/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit
import CoreData

class ProfileEditViewController: UIViewController {
    
    @IBOutlet weak var scrollVC: UIScrollView!
    @IBOutlet var stackAllFields: UIStackView!
    @IBOutlet weak var btnEdit: UIBarButtonItem!
    @IBOutlet weak var scrollContainerView: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet var txtFiledColln: [UITextField]!
    @IBOutlet weak var fieldFullName: UITextField!
    @IBOutlet weak var fieldFatherName: UITextField!
    @IBOutlet weak var fieldStudentPhNumber: UITextField!
    @IBOutlet weak var fieldParentPhNumber: UITextField!
    @IBOutlet weak var txtViewAddress: UITextView!
    var strTitle = ""
    @IBOutlet weak var lblStudentPhNumber: UILabel!
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblParentPhNumber: UILabel!
    
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
        
        self.title = strTitle
        self.imgProfile.layer.cornerRadius = 30
        self.imgProfile.clipsToBounds = true
        
        self.scrollContainerView.addSubview(self.stackAllFields)
        self.stackAllFields.translatesAutoresizingMaskIntoConstraints = false
        self.stackAllFields.leadingAnchor.constraint(equalTo: self.scrollContainerView.leadingAnchor).isActive = true
        self.stackAllFields.topAnchor.constraint(equalTo: self.scrollContainerView.topAnchor).isActive = true
        self.stackAllFields.trailingAnchor.constraint(equalTo: self.scrollContainerView.trailingAnchor).isActive = true
        self.stackAllFields.bottomAnchor.constraint(equalTo: self.scrollContainerView.bottomAnchor).isActive = true
        self.stackAllFields.widthAnchor.constraint(equalTo: self.scrollContainerView.widthAnchor).isActive = true
        
        for field in txtFiledColln
        {
            field.backgroundColor = .clear
            field.layer.borderColor = UIColor.gray.cgColor
            field.layer.borderWidth = 0.5
            field.tintColor = .white
            field.textColor = .gray
            field.isUserInteractionEnabled = false
        }
        
        self.txtViewConfiguration()
                
        btnUpdate.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        
        self.showProfileData()
        
        if userDetails[0].roles == Role.Student_Parent.rawValue
        {
            self.lblStudentPhNumber.text = "Student Contact Number"
            self.lblParentPhNumber.text = "Emergency Contact Number"
            
        }
        else
        {
            self.lblStudentPhNumber.text = "Contact Number"
            self.lblParentPhNumber.isHidden = true
            self.fieldParentPhNumber.isHidden = true
        }
    }
    
    func txtViewConfiguration()
    {
        self.txtViewAddress.backgroundColor = .clear
        self.txtViewAddress.layer.borderColor = UIColor.gray.cgColor
        self.txtViewAddress.layer.borderWidth = 0.5
        self.txtViewAddress.textColor = .gray
        self.txtViewAddress.tintColor = .white
       // self.txtViewAddress.addBorder()
        self.txtViewAddress.autocorrectionType = .no
    }

    func showProfileData()
    {
        fieldFullName.text = userDetails[0].fullname
        fieldFatherName.text = userDetails[0].father_spouse
        fieldStudentPhNumber.text = userDetails[0].mobile
        fieldParentPhNumber.text = userDetails[0].parent_phone_number
        
        let addre = UserDefaults.standard.value(forKey: "profAddress")
        
        if addre == nil
        {
           txtViewAddress.text = userDetails[0].address
        }
        else
        {
            txtViewAddress.text = addre as? String
        }
        
        lblFullName.text = userDetails[0].fullname
        imgProfile.loadImageUsingCache(withUrl: userDetails[0].profile_pic ?? "")

    }
    
    @IBAction func btnUpdateClicked(_ sender: UIButton)
    {
        if txtViewAddress.text != ""
        {
            CommonObject().showHUD()
            
            let parmsDict = ["address":txtViewAddress.text ?? "","id":userDetails[0].id ?? 0] as [String : Any]

            CommonObject().getDataFromServer(urlString: updateUserAddress, method: .POST, model: Success_Error.self, paramsDict: parmsDict) { (data, resp, err) in
              
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
                        
                        AlertView.shared.showAlert(message: data?.msg ?? "", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                        
                        self.txtViewAddress.layer.borderColor = UIColor.gray.cgColor
                        self.txtViewAddress.textColor = .gray
                        self.txtViewAddress.isEditable = false
                     //   self.saveUserDta(address: self.txtViewAddress.text)
                        
                        UserDefaults.standard.set(self.txtViewAddress.text, forKey: "profAddress")
                        
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
            AlertView.shared.showAlert(message: "Please add Address", toView: self, ButtonTitles: ["OK"], ButtonActions: [
                {OKCLicked in
                    self.dismiss(animated: true, completion: nil)
                },nil])
        }
    }
    
    func saveUserDta(address:String)
    {
        let request : NSFetchRequest<ProfileData>
        request = ProfileData.fetchRequest()
        do
        {
            let results = try context.fetch(request)
            if results.count > 0
            {
             //   for item in results {
                    
                    let logindata = results[0].model as! LoginDetails
                    
                    logindata.details?[0].address = address
                    
             //   }
                
                results[0].model = logindata
                
                print("Storing Data..")
                do
                {
                    try context.save()
                    
                               
                 } catch {
                     print("Storing data Failed")
                 }
           }
        }
        catch let err
        {
           print(err.localizedDescription)
        }
        
    }
    
    @IBAction func btnEditClicked(_ sender: UIBarButtonItem)
    {
        
        self.txtViewAddress.isEditable = true
        self.txtViewAddress.textColor = .white
        self.txtViewAddress.layer.borderColor = UIColor.white.cgColor
        self.txtViewAddress.becomeFirstResponder()
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
