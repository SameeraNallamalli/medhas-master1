//
//  RegisterViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 25/11/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnMobileNumber: UIButton!
    @IBOutlet weak var btnChange: UIButton!
    @IBOutlet weak var fieldOTP: UITextField!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var lblOTPExpiredTime: UILabel!
    
    var userID = ""
    
    var OTPExpireTime:Int = 90
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.addCustomBottomLine(color:UIColor.orange, height: 0.7)

        self.addGradientBGColor()
        fieldOTP.addBorder()
        //btnChange.addBorder()
       // btnVerify.addColors(titleColor: ColorsConfig.btnTitleColor, bgColor: nil, borderColor: .black)
        // btnMobileNumber.addBorder()
        btnResend.Disable()
        
        self.btnVerify.addColors(titleColor: .white, bgColor:.clear, borderColor: ColorsConfig.footerColor.withAlphaComponent(0.7))
        
        btnMobileNumber.setTitle(userID, for: .normal)
        
        lblOTPExpiredTime.text = ""
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            
            self.OTPExpireTime = self.OTPExpireTime - 1
            self.lblOTPExpiredTime.text = "Time left \(self.OTPExpireTime) seconds"
            
            if self.OTPExpireTime == 0
            {
                timer.invalidate()
                self.lblOTPExpiredTime.text = ""
              //  self.btnResend.addColors(titleColor: ColorsConfig.btnTitleColor, bgColor: nil, borderColor: .black)
                self.btnResend.addColors(titleColor: .white, bgColor:.clear, borderColor: ColorsConfig.footerColor.withAlphaComponent(0.7))

            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
     //   self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func btnBackClicked(_ sender: UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func tappedBG(_ sender: UITapGestureRecognizer)
    {
        fieldOTP.resignFirstResponder()
    }
    
    @IBAction func btnChangeClicked(_ sender: UIButton)
    {
       // let _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnVerifyClicked(_ sender: UIButton)
    {
        if fieldOTP.text == ""
        {
            CommonObject().showAlert(message: Alert_Empty_OTP, toView: self)
        }
        else
        {
            self.verifyOTP()
        }
        
    }
    
    @IBAction func btnResendClicked(_ sender: UIButton)
    {
        self.resendOTP()
    }
    
    @objc func timerChanged()
    {
        
    }
    
    func verifyOTP()
    {
        CommonObject().showHUD()
        let paramsDict = ["email" : userID, "code" : fieldOTP.text!] as [String : Any]
         
        CommonObject().getDataFromServer(urlString: verifyAccount, method: .POST, model: Success_Error.self, paramsDict: paramsDict) { (data, resp, err) in

             if err == nil && resp != nil
             {
                 print(data!)
                if data?.status == "error"
                {
                    DispatchQueue.main.async {
                     
                        CommonObject().showAlert(message: data?.msg ?? Alert_OTP_Failure, toView: self)
                    }
                     
                }
                else if data?.status == "success"
                {
                    DispatchQueue.main.async {
                        
                        AlertView.shared.showAlert(message: Alert_OTP_Success, toView: self, ButtonTitles: ["OK"], ButtonActions: [{action1 in
                         //   let _ = self.navigationController?.popViewController(animated: true)
                            self.pushToResetPasswordView()
                            
                            
                        },nil])
                        
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

    func resendOTP()
    {
        CommonObject().showHUD()
        let paramsDict = ["email" : userID]
        
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
                        
                        AlertView.shared.showAlert(message: Alert_OTP_Sent, toView: self, ButtonTitles: ["OK"], ButtonActions: [{action1 in
                                                        
                        },nil])
                        
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
    
    func pushToResetPasswordView()
    {
        
        let resetPassVC = (MainSB.instantiateViewController(withIdentifier: "ResetPasswordViewController") as? ResetPasswordViewController)!
        resetPassVC.userID = userID
        self.navigationController?.pushViewController(resetPassVC, animated: true)
    }

}
extension RegisterViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        fieldOTP.resignFirstResponder()

        return true
    }
}
