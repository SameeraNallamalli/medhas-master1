//
//  PDDetailsViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 28/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit

class Show_PD_TutorialsViewController: UIViewController {
    
    @IBOutlet weak var tblPDDetails: UITableView!
    @IBOutlet weak var lblError: UILabel!
    var arrPDDetails = [PDDetails]()
    var isLoadMore = false
    var strTitle = ""
    var isPDDetails = true
    
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
         
    }
    
    var strSelectedClass = ""
    var strSelectedSection = ""
    var idSelectedClass = 0
    var idSelectedSection = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = strTitle
        self.addGradientBGColor()
         tblPDDetails.addAppearanceWith(isHide: false)
        
        if userDetails[0].roles == Role.Student_Parent.rawValue
        {
            strSelectedClass = userDetails[0].class_education ?? ""
            idSelectedClass = Int(userDetails[0].class_education ?? "0") ?? 0
            
            strSelectedSection = userDetails[0].section ?? ""
            idSelectedSection = Int(userDetails[0].section ?? "0") ?? 0
        }
        
        lblError.text = ""
        lblError.textColor = .white
        CommonObject().showHUD()
        
        if isPDDetails
        {
            self.getPDData()
            self.title = "Personality Development"
            
        }
        else
        {
            self.getTutorialData()
            self.title = "Tutorials"
        }
        
        
    }

    
    @objc func btnShowMoreClicked(sender:UIButton)
    {
        if sender.imageView?.image == #imageLiteral(resourceName: "DownArrow")
        {
            isLoadMore = true
        }
        else
        {
            isLoadMore = false
        }
        
        let sections = IndexSet.init(integer: sender.tag)
        tblPDDetails.reloadSections(sections, with: .fade)
    }
    
   func getPDData()
   {
        
    let parmsDict = ["class_id":"","section_id":""] as [String : Any]

       CommonObject().getDataFromServer(urlString: getPDDetails, method: .POST, model: PDData.self, paramsDict: parmsDict) { (data, resp, err) in
        
        if err == nil && resp != nil
        {
            print(data!)
            if data?.status == "error"
            {
                DispatchQueue.main.async {
                 
                    AlertView.shared.showAlert(message: data?.msg ?? Alert_Invaid_ID_Pass, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                     CommonObject().dismisHUD()
                }

            }
            else if data?.status == "success"
            {
                if data?.details?.count ?? 0 > 0
                {
                DispatchQueue.main.async {
                    self.arrPDDetails = (data?.details)!
                    /*
                    if self.arrPDDetails.count > 0
                    {
                        self.arrPDDetails = self.arrPDDetails.filter({$0.id == self.userDetails[0].id})

                        if self.arrPDDetails.count == 0
                        {
                            self.lblError.text = Alert_NoPD_Tutorial
                        }
                    }
                    else
                    {
                        self.lblError.text = Alert_NoPD_Tutorial
                    
                    }
                     */
                        self.tblPDDetails.reloadData()
                        CommonObject().dismisHUD()
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        self.lblError.text = Alert_NoPD_Tutorial
                        CommonObject().dismisHUD()
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
                         CommonObject().dismisHUD()
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        let statusCode = resp as! HTTPURLResponse
                        AlertView.shared.showAlert(message: "Erro in network\nStatus Code :\(statusCode.statusCode)", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                         CommonObject().dismisHUD()
                    }
                }
                
            }
        }

       }

   }
    func getTutorialData()
    {
        let parmsDict = ["class_id":idSelectedClass] as [String : Any]
        
        CommonObject().getDataFromServer(urlString: getTutorialDetails, method: .POST, model: PDData.self, paramsDict: parmsDict) { (data, resp, err) in
         
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
               // Do with data
               if data?.details?.count ?? 0 > 0
               {
                 DispatchQueue.main.async {
                    self.arrPDDetails = (data?.details)!
                    /*
                    if self.arrPDDetails.count > 0
                    {
                        self.arrPDDetails = self.arrPDDetails.filter({$0.id == self.userDetails[0].id})
                        
                        if self.arrPDDetails.count == 0
                        {
                            self.lblError.text = Alert_NoPD_Tutorial
                        }
                    }
                    else
                    {
                        self.lblError.text = Alert_NoPD_Tutorial
                    }
                    */
                    
                     self.tblPDDetails.reloadData()
                 }
               }
                else
               {
                 DispatchQueue.main.async {
                        self.lblError.text = Alert_NoPD_Tutorial
                    }
                
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

    // MARK: - Navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}


extension Show_PD_TutorialsViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrPDDetails.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tblPDDetails.dequeueReusableCell(withIdentifier: "SuggestionsTableViewCell") as! SuggestionsTableViewCell
        
        cell.backgroundColor = .clear
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 0.5

        if isPDDetails
        {
            cell.lblName.text = arrPDDetails[indexPath.section].submitted_date?.toDate(Format: DF_dd_MM_yyyy) ?? ""
            cell.lblClass.text = arrPDDetails[indexPath.section].category ?? ""
            cell.lblSection.text = arrPDDetails[indexPath.section].sub_category ?? ""
            cell.lblCategory.text = arrPDDetails[indexPath.section].content_heading ?? ""
            cell.lblMessage.text = arrPDDetails[indexPath.section].content ?? ""
        }
        else
        {
            cell.lblName.text = arrPDDetails[indexPath.section].submitted_date?.toDate(Format: DF_dd_MM_yyyy) ?? ""
            cell.lblClass.text = "Class : \(arrPDDetails[indexPath.section].class ?? "")"
            cell.lblSection.text = "Subject : \(arrPDDetails[indexPath.section].subject ?? "")"
            cell.lblCategory.text = arrPDDetails[indexPath.section].content_heading ?? ""
            cell.lblMessage.text = arrPDDetails[indexPath.section].content ?? ""
        }

        
        let msgNumberOfLines = cell.lblMessage.maxNumberOfLines + cell.lblLink.numberOfLines
       // print("Number of lines : \(cell.lblMessage.maxNumberOfLines)")
        
        if arrPDDetails[indexPath.section].content_link!.count != 0
         {
           // let more = #imageLiteral(resourceName: "NextArrow")
           // cell.accessoryView = UIImageView(image: more)
            cell.tintColor = .white
            cell.lblLink.text = "Open Link"
            cell.lblLink.isHidden = false
         }
         else
         {
            cell.accessoryView = UIImageView(image: UIImage())
            cell.lblLink.isHidden = true
            
         }
        
        if msgNumberOfLines > 2
        {
            cell.btnShowMore.isHidden = false
            cell.btnShowMore.tag = indexPath.section
            cell.btnShowMore.addTarget(self, action: #selector(btnShowMoreClicked(sender:)), for: .touchUpInside)
           // cell.btnShowMore.isSelected = false
            cell.btnShowMore.setImage(#imageLiteral(resourceName: "DownArrow"), for: .normal)
            
            if isLoadMore
            {
                cell.lblMessage.numberOfLines = 0
                cell.btnShowMore.setImage(#imageLiteral(resourceName: "UpArrow"), for: .normal)
            }
            else
            {
                cell.lblMessage.numberOfLines = 2
                cell.btnShowMore.setImage(#imageLiteral(resourceName: "DownArrow"), for: .normal)
            }
            
            
        }
        else
        {
            cell.btnShowMore.isHidden = true
        }

 
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20
//    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let urlString = arrPDDetails[indexPath.section].content_link ?? ""
        
        let validUrlString = urlString.hasPrefix("http") ? urlString : "http://\(urlString)"
        
        if let url = URL(string:validUrlString.replacingOccurrences(of: " ", with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            
            if UIApplication.shared.canOpenURL(url)
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            else
            {
                AlertView.shared.showAlert(message: "Link is not valid", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            }
        }
    }
    
}
