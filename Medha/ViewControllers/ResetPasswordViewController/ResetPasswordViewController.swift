//
//  ResetPasswordViewController.swift
//  Medha
//
//  Created by Ganesh on 12/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var fieldEnterPassword: UITextField!
    
    @IBOutlet weak var fieldReEnterPassword: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var userID = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addGradientBGColor()
        fieldEnterPassword.addBorder()
        fieldReEnterPassword.addBorder()
        
        btnSubmit.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton)
    {
        if fieldEnterPassword.text == "" || fieldReEnterPassword.text == ""
        {
            AlertView.shared.showAlert(message: Alert_Empty_Fields, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
        }
        else
        {
            if fieldEnterPassword.text == fieldReEnterPassword.text
            {
                self.VerifyPassword()
            }
            else
            {
                AlertView.shared.showAlert(message: Alert_SetPass_NotMatch, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            }
        }
        
    }
    
    func popToLogin()
    {
        let popVCs = self.navigationController?.viewControllers
        
        if popVCs?.count ?? 0 > 0
        {
            for(_,VC) in (popVCs?.enumerated())!
            {
                if VC.isKind(of: LoginViewController.self)
                {
                    let loginVC = VC as! LoginViewController
                    
                    self.navigationController?.popToViewController(loginVC, animated: true)
                }
            }
        }
  
    }
    
    func VerifyPassword()
    {
        CommonObject().showHUD()
        let paramsDict = ["email" : userID, "password" :fieldEnterPassword.text!] as [String : Any]
         
        CommonObject().getDataFromServer(urlString: updatePassword, method: .POST, model: Success_Error.self, paramsDict: paramsDict) { (data, resp, err) in

             if err == nil && resp != nil
             {
                 print(data!)
                if data?.status == "error"
                {
                    DispatchQueue.main.async {
                        
                        AlertView.shared.showAlert(message: data?.msg ?? "OOPS!", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                         CommonObject().dismisHUD()
                    }
                     
                }
                else if data?.status == "success"
                {
                     CommonObject().dismisHUD()
                    DispatchQueue.main.async {
                        
                        AlertView.shared.showAlert(message: Alert_SetPass_Success, toView: self, ButtonTitles: ["OK"], ButtonActions: [{action1 in
                             CommonObject().showHUD()
                            self.popToLogin()
                             CommonObject().dismisHUD()
                        },nil])
                        
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

}
extension ResetPasswordViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        fieldEnterPassword.resignFirstResponder()
        fieldReEnterPassword.resignFirstResponder()
        return true
    }
}
