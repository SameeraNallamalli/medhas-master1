//
//  FeePaidAndPendingViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 08/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit

class FeePaidAndPendingViewController: UIViewController {
    
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var tblFeesDetails: UITableView!
    @IBOutlet weak var lblDate: UILabel!
    var strFeeStatus = ""
    var arrFeeDetails = [CommonDetails]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tblFeesDetails.tableFooterView = UIView()
        tblFeesDetails.backgroundColor = .clear
        
        self.lblHeading.text = "Fees paid summary"
        self.lblDate.text = "Date"
        
        self.addGradientBGColor()
    }
    
    @objc func showPaymentReceipts(sender : UIButton)
    {
        DispatchQueue.main.async {
            
            let paymnetReceiptURL = self.arrFeeDetails[0].fees_details?[sender.tag].payment_path
            
            if paymnetReceiptURL == nil || paymnetReceiptURL?.count == 0
            {
                AlertView.shared.showAlert(message: Alert_No_Payment_Receipt, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])                
            }
            else
            {
                let urlwithOutSpaces = paymnetReceiptURL?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                  
                  guard let url = urlwithOutSpaces else { return }
                  
                  if UIApplication.shared.canOpenURL(URL(string: url)!)
                  {
                      UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
                  }
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
extension FeePaidAndPendingViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFeeDetails[0].fees_details?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblFeesDetails.dequeueReusableCell(withIdentifier: "FeePaidAndPendingTableViewCell") as! FeePaidAndPendingTableViewCell
        
        let feeData = arrFeeDetails[0].fees_details?[indexPath.row]
        
        cell.lblDate.text = feeData?.date?.toDate(Format: DF_dd_MM_yyyy)
        cell.lblAmount.text = feeData?.amount_paid
        
        cell.btnView.setTitle("Info", for: .normal)
        cell.btnView.tag = indexPath.row
        cell.btnView.addTarget(self, action: #selector(showPaymentReceipts(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        print("whooo")
    }
    
}
