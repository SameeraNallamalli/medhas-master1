//
//  PaymentsViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 08/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit

class PaymentsViewController: UIViewController {
    
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnFeeDetials: UIButton!
    @IBOutlet weak var tblFeeDetails: UITableView!
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    @IBOutlet weak var lblFeesPaid: UILabel!
    @IBOutlet weak var lblFeesPending: UILabel!
    @IBOutlet weak var btnSummary: UIButton!
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var stackResults: UIStackView!
    
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
    }
    
    var arrMonth = [String]()
    var currentMonthIndex = 2
    var currentDate = Date()
    var changedDate = Date()
    let calendar = Calendar.current// or e.g. Calendar(identifier: .persian)
    
    var arrFeeTypes = [defaultList]()
    var feeTypeStr = ""
    var feeTypeID = 0
    
    var arrFeeDetails = [CommonDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let calendar = Calendar.current
       // calendar.component(.year, from: currentDate)
       let month =  calendar.component(.month, from: currentDate)
       // calendar.component(.day, from: currentDate)
        
        if month < 4
        {
            let curYear = calendar.component(.year, from: changedDate)
            let preyearDate = calendar.date(byAdding: .year, value: -1, to: changedDate)!
            let prevYear = calendar.component(.year, from: preyearDate)
            lblYear.text = "\(prevYear) - \(curYear)"
        }
        else
        {            
            changedDate = calendar.date(byAdding: .year, value: 1, to: changedDate)!
            
            let curYear = calendar.component(.year, from: changedDate)
            let preyearDate = calendar.date(byAdding: .year, value: -1, to: changedDate)!
            let prevYear = calendar.component(.year, from: preyearDate)
            lblYear.text = "\(prevYear) - \(curYear)"
            
        }
        
        
        btnSummary.addColors(titleColor: .white, bgColor: .clear, borderColor: .white)
      //  btnView.addColors(titleColor: .white, bgColor: .clear, borderColor: .white)
        btnFeeDetials.addColors(titleColor: .white, bgColor: .clear, borderColor: .white)
        self.addGradientBGColor()
        arrMonth = calendar.shortMonthSymbols
        tblFeeDetails.addAppearanceWith(isHide: true)
        stackResults.alpha = 0.0
        
        btnView.setTitle("", for: .normal)
        btnView.isUserInteractionEnabled = false
    }
    
    @IBAction func btnPrevClicked(_ sender: UIButton)
    {
        let selectedYearDate = calendar.date(byAdding: .year, value: -1, to: changedDate)!
        changedDate = selectedYearDate
        let selectedYear = "\(calendar.component(.year, from: changedDate))"
        let preYearDate = calendar.date(byAdding: .year, value: -1, to: changedDate)!
        let prevYear = "\(calendar.component(.year, from: preYearDate))"
        lblYear.text = "\(prevYear) - \(selectedYear)"
        
        
    //    let curYear = calendar.component(.year, from: changedDate)
      //  let preyearDate = calendar.date(byAdding: .year, value: -1, to: changedDate)!
        //let prevYear = calendar.component(.year, from: preyearDate)

    }
    @IBAction func btnNextClicked(_ sender: UIButton)
    {
        
        let selectedYearDate = calendar.date(byAdding: .year, value: 1, to: changedDate)!
        changedDate = selectedYearDate
        let selectedYear = "\(calendar.component(.year, from: changedDate))"
        let preYearDate = calendar.date(byAdding: .year, value: -1, to: changedDate)!
        let prevYear = "\(calendar.component(.year, from: preYearDate))"
        lblYear.text = "\(prevYear) - \(selectedYear)"
        
    }
    
    @IBAction func btnFeesDetailsClicked(_ sender: UIButton)
    {
        if tblFeeDetails.isHidden
        {
            UIView.animate(withDuration: 0.2) {
                
                self.tblFeeDetails.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.2) {
                
                self.tblFeeDetails.isHidden = true
            }
        }
        
    }
    func getPaymentsData()
    {
        if feeTypeStr != ""
        {
            let parmsDict = ["student_id":userDetails[0].register_num ?? "0","academic_year":self.lblYear.text!,"fees_type":feeTypeID] as [String : Any]

             CommonObject().getDataFromServer(urlString: getPaymentsByYear, method: .POST, model: Payments.self, paramsDict: parmsDict) { (data, resp, err) in
               
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
                         
                         if data?.details?.count ?? 0 > 0
                         {
                             UIView.animate(withDuration: 0.3) {
                     
                                 self.stackResults.alpha = 1.0
                             }
                            
                            self.arrFeeDetails = data?.details ?? []
                            
                            self.updatedata(feeData: self.arrFeeDetails[0])
                            
                            CommonObject().dismisHUD()

                         }
                         else
                         {
                            AlertView.shared.showAlert(message: Alert_Empty_Payments, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                            CommonObject().dismisHUD()
                            UIView.animate(withDuration: 0.3) {
                    
                                self.stackResults.alpha = 0.0
                            }
                            
                         }
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
        else
        {
            AlertView.shared.showAlert(message:Alert_Empty_feeType , toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            CommonObject().dismisHUD()
        }
    }
    
    func updatedata(feeData: CommonDetails)
    {
        let totalAmountPaid = (feeData.total_amount ?? 0) - (feeData.pending_amount ?? 0)
        
        lblFeesPaid.text = "\(totalAmountPaid)"
        lblTotalAmount.text = "Total Amount  \(feeData.total_amount ?? 0)"
        lblFeesPending.text = "\(feeData.pending_amount ?? 0)"
    }
    
    @IBAction func btnSummaryClicked(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: segue_FeeDetails, sender: "Paid")
    }
    
    @IBAction func btnViewClicked(_ sender: UIButton)
    {
         self.performSegue(withIdentifier: segue_FeeDetails, sender: "Pending")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == segue_FeeDetails
        {
            let feeDetaislVC = segue.destination as! FeePaidAndPendingViewController
            
            feeDetaislVC.strFeeStatus = sender as! String
            feeDetaislVC.arrFeeDetails = arrFeeDetails
            
        }
        
    }
    
    

}
extension PaymentsViewController : UITableViewDelegate,UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFeeTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "FeeDetails")!
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.textAlignment = .center
        
        cell.textLabel?.text = arrFeeTypes[indexPath.row].name
        
        if cell.textLabel?.text == feeTypeStr
        {
            cell.accessoryType = .checkmark
            cell.tintColor = .white
        }
        else
        {
            cell.accessoryType = .none
        }
        
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        feeTypeStr = ""
        feeTypeID = 0
        btnFeeDetials.setTitle(arrFeeTypes[indexPath.row].name, for: .normal)
        feeTypeStr = arrFeeTypes[indexPath.row].name!
        feeTypeID = arrFeeTypes[indexPath.row].id!
        
        UIView.animate(withDuration: 0.3) {
            
            self.tblFeeDetails.isHidden = true
        }
        
        self.tblFeeDetails.reloadData()
        
        DispatchQueue.main.async {
            CommonObject().showHUD()
            
            self.getPaymentsData()
        }
        
        
        
    }
    
}
