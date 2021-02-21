//
//  LoginViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 25/11/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    //@IBOutlet weak var imgBackground: UIImageView!
    //@IBOutlet weak var imgLogo: UIImageView!
   /* @IBOutlet weak var fieldUserID: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnNewUser: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var stackLoginID: UIStackView!
    @IBOutlet weak var stackPassword: UIStackView!
    @IBOutlet weak var stackFooter: UIStackView! */
    
    var state = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()

     /*   fieldUserID.addBorder()
        fieldPassword.addBorder()
        btnLogin.addColors(titleColor: .white, bgColor: .clear, borderColor: .black)*/
        
       // btnNewUser.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
      //  btnForgotPassword.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        
        //stackFooter.addBackground(withBGColor:ColorsConfig.footerColor, borderColor: .clear)
       state = kLogin
        
        self.navigationController?.addCustomBottomLine(color:UIColor.clear, height: 0.7)
        
       // btnLogin.imageV.image = #imageLiteral(resourceName: "NextArrow")
        //btnLogin.titleV.text = "Sign In" 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addGradientBGColor()
        UIView.animate(withDuration: 0.25)
        {
         /*   self.stackPassword.isHidden = false
            self.btnForgotPassword.isHidden = false
            self.btnLogin.setTitle("Sign In", for: .normal)
            self.btnNewUser.setTitle("New User", for: .normal) */
        }
        state = kLogin
    }
    
    //MARK: - Button Actions
    //MARK: -
    
    @IBAction func bfTapped(_ sender: UITapGestureRecognizer) {
        
       // fieldPassword.resignFirstResponder()
        // fieldUserID.resignFirstResponder()
    }
    
  /*  @IBAction func btnLoginClicked(_ sender: UIButton)
    {
        
        if state == kRegister
        {
            if fieldUserID.text == ""
            {
                CommonObject().showAlert(message: Alert_Empty_UserID, toView: self)
            }
            else
            {
                 self.RegisterAccount()
            
            }
        }
        else if state == kLogin
        {
            if fieldUserID.text != "" && fieldPassword.text != ""
            {
                if fieldUserID.text!.isValidPhoneNumber
                {
                    self.LoginToAccount()
                }
                else
                {
                    AlertView.shared.showAlert(message: Alert_Invalid_UserID, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])

                }

            }
            else
            {
                if fieldUserID.text == ""
                {
                    AlertView.shared.showAlert(message: Alert_Empty_UserID, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                }
                if fieldPassword.text == ""
                {
                    AlertView.shared.showAlert(message: Alert_Empty_Password, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                }

            }
    
        }
 
    }
    @IBAction func btnNewUserClicked(_ sender: UIButton)
    {
        
        if self.btnNewUser.titleLabel?.text == "New User" // This will be register
        {
            fieldPassword.text = ""
            fieldUserID.text = ""
            
            UIView.animate(withDuration: 0.25) {
                self.stackPassword.isHidden = true
                self.btnForgotPassword.isHidden = true
                self.btnLogin.setTitle(kRegister, for: .normal)
                self.btnNewUser.setTitle("<- Login", for: .normal)
            }
            
            state = kRegister
            
        }
        else // This will be Login/Sign-In
        {
            UIView.animate(withDuration: 0.25) {
                self.stackPassword.isHidden = false
                self.btnForgotPassword.isHidden = false
                self.btnLogin.setTitle("Sign In", for: .normal)
                self.btnNewUser.setTitle("New User", for: .normal)
            }
            
            state = kLogin
        }
        
        fieldUserID.resignFirstResponder()
        fieldPassword.resignFirstResponder()
        
    }
    @IBAction func btnForgotPasswordClicked(_ sender: UIButton)
    {
        if self.btnNewUser.titleLabel?.text == "New User" // This will be register
        {
            fieldPassword.text = ""
            fieldUserID.text = ""
            
            UIView.animate(withDuration: 0.25) {
                self.stackPassword.isHidden = true
                self.btnForgotPassword.isHidden = true
                self.btnLogin.setTitle("Submit", for: .normal)
                self.btnNewUser.setTitle("<- Login", for: .normal)
            }
            
            state = kRegister
            
        }
        else // This will be Login/Sign-In
        {
            UIView.animate(withDuration: 0.25) {
                self.stackPassword.isHidden = false
                self.btnForgotPassword.isHidden = false
                self.btnLogin.setTitle("Sign In", for: .normal)
                self.btnNewUser.setTitle("New User", for: .normal)
            }
            
            state = kLogin
        }
        
        fieldUserID.resignFirstResponder()
        fieldPassword.resignFirstResponder()
    }
    
    //MARK: - Public Functions
    //MARK: -
    
    func RegisterAccount()
    {
        CommonObject().showHUD()
        let paramsDict = ["email" : fieldUserID.text!]
        
        CommonObject().getDataFromServer(urlString: registerAccount, method: .POST, model: Success_Error.self, paramsDict: paramsDict) { (data, resp, err) in

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
                    DispatchQueue.main.async {
                        
                       // AlertView.shared.showAlert(message: (data?.msg)!, toView: self, ButtonTitles: ["OK"], ButtonActions: [{action1 in
                            
                            let registerVC = (MainSB.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController)!

                            registerVC.userID = self.fieldUserID.text ?? ""

                            self.navigationController?.pushViewController(registerVC, animated: true)
                            
                      //  },nil])
                        
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
    
    func LoginToAccount()
    {
        CommonObject().showHUD()
        let pushToekn = UserDefaults.standard.value(forKey: pushKey)
        let version =  Bundle.main.releaseVersionNumber
        let build = Bundle.main.buildVersionNumber!
        
        let appVersion = version! + "(\(build))"
        
        
        let paramsDict = ["email" : fieldUserID.text!, "password" : fieldPassword.text!,"push_token" : pushToekn ?? "0","platform":"iOS","version":appVersion]  as [String : Any]
        
//        AlertView.shared.showAlert(message: pushToekn as! String, toView: self, ButtonTitles: ["OK"], ButtonActions: [{OkCLicked in
//
//            },nil])
        
       CommonObject().getDataFromServer(urlString: accountLogin, method: .POST, model: LoginDetails.self, paramsDict: paramsDict) { (data, resp, err) in

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
                   
                    DispatchQueue.main.async {
                          
                         self.saveUserData(userModel: data!)
                        
//                        AlertView.shared.showAlert(message:Alert_login_Success, toView: self, ButtonTitles: ["OK"], ButtonActions: [{action1 in
//
//                            self.saveUserData(userModel: data!)
//
//
//                        },nil])
                        
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
    
    func saveUserData(userModel:LoginDetails)
    {
        
        let request : NSFetchRequest<ProfileData>
        request = ProfileData.fetchRequest()
        do
        {
            let results = try context.fetch(request)
            
            if results.count > 0
            {
                for item in results {
                    
                    context.delete(item)
                }

           }
           
        }
        catch let err
        {
           print(err.localizedDescription)
        }

        let entity = NSEntityDescription.entity(forEntityName: "ProfileData", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context) as! ProfileData
        
        newUser.model = userModel
        
         print("Storing Data..")
        do
        {
            try context.save()
           
            self.pushToHomeView()
            
         } catch {
             print("Storing data Failed")
         }
        
    }
    

    
    //MARK: - Segue Navigation
    //MARK: -
    
    func pushToHomeView()
    {
         CommonObject().dismisHUD()
        let HomeVC = MainSB.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        self.navigationController?.pushViewController(HomeVC, animated: true)
        
    }

}

// MARK: - UITextFieldDelegate
//MARK: -

extension LoginViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        fieldPassword.resignFirstResponder()
        fieldUserID.resignFirstResponder()
        return true
    }
}
*/
}
