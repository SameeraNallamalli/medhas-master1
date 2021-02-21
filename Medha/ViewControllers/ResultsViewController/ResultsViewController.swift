//
//  ResultsViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 24/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var btnSelectExamType: UIButton!
    @IBOutlet weak var tblExamDetails: UITableView!
    @IBOutlet weak var btnViewResults: UIButton!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblMaxMarks: UILabel!
    @IBOutlet weak var lblSecuredMarks: UILabel!
    @IBOutlet weak var tblResults: UITableView!
    @IBOutlet weak var tblExanTypesHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stackTotalMarks: UIStackView!
    @IBOutlet weak var lblTotalMarks: UILabel!
    
    @IBOutlet weak var stackAvg: UIStackView!
    @IBOutlet weak var lblAvg: UILabel!
    @IBOutlet weak var stackRank: UIStackView!
    @IBOutlet weak var stackBottomResults: UIStackView!
    
    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var stackResults: UIStackView!
    var arrSubjects = [defaultList]()
    
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
         
    }
    
    var arrSecuredMarks = ["80","59","90","76","80","75","93","97"]
    
    var arraveragesLbl = ["Total Marks","Average Percentage","Rank"]
    var arraveragesresults = ["650","78%","B"]
    
    var arrResults = [CommonDetails]()
    
    var arrExamTypes = [defaultList]()
    
    var examTypeID = 0
    var examTypeStr = ""
    
    let numberOfCellsPerRow: CGFloat = 3
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Results"
        self.addGradientBGColor()
        tblResults.addAppearanceWith(isHide: false)
        tblExamDetails.addAppearanceWith(isHide: true, borderColor: .orange)

        btnSelectExamType.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        btnViewResults.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        
        stackResults.isHidden = true
        stackBottomResults.isHidden = true
        
//        stackTotalMarks.addBorderWith(borders: [.Left,.Bottom,.Right,.Top], BGColor: UIColor.white.withAlphaComponent(0.5), borderColor: .white,cornerRadius: true)
//
//        stackAvg.addBorderWith(borders: [.Left,.Bottom,.Right,.Top], BGColor: UIColor.white.withAlphaComponent(0.5), borderColor: .white,cornerRadius: true)
//
//        stackRank.addBorderWith(borders: [.Left,.Bottom,.Right,.Top], BGColor: UIColor.white.withAlphaComponent(0.5), borderColor: .white,cornerRadius: true)

        stackTotalMarks.addBackground(withBGColor: UIColor.white.withAlphaComponent(0.5), borderColor: .white)
        stackAvg.addBackground(withBGColor: UIColor.white.withAlphaComponent(0.5), borderColor: .white)
        stackRank.addBackground(withBGColor: UIColor.white.withAlphaComponent(0.5), borderColor: .white)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (self.tblExamDetails.contentSize.height < tblExanTypesHeightConstraint.constant)
        {
             tblExanTypesHeightConstraint.constant = self.tblExamDetails.contentSize.height
        }
        
       
    }
    
    @IBAction func btnSelectExamTypeClicked(_ sender: UIButton)
    {
        if tblExamDetails.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblExamDetails.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblExamDetails.isHidden = true
            }
        }
        
    }
    
    @IBAction func btnViewResultsClicked(_ sender: UIButton)
    {
        
        if !(tblExamDetails.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblExamDetails.isHidden = true
                
            }
        }
        if examTypeStr != ""
        {
            
            self.getExamResults()
        }
        else
        {
            
            AlertView.shared.showAlert(message: Alert_EmptyExamType, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            
        }
        
        
    }
    
    func getExamResults()
     {
         CommonObject().showHUD()
         
        let parmsDict = ["exam_type_id":examTypeID,"student_id":userDetails[0].register_num!] as [String : Any]
         
         CommonObject().getDataFromServer(urlString: getResultsByStudentId, method: .POST, model: Results.self, paramsDict: parmsDict) { (data, resp, err) in
             
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
                            self.arrResults = data?.details ?? []
                            self.tblResults.reloadData()
                            self.stackResults.isHidden = false
                            self.updateAvgDetails(Results: self.arrResults)
                            
                         }
                         else
                         {
                             DispatchQueue.main.async {
                                 AlertView.shared.showAlert(message: Alert_NoResults, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                                 
                             }
                         }
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
    
    func updateAvgDetails(Results:[CommonDetails])
    {
        self.stackBottomResults.isHidden = false
        
        var total = 0
        var securedTotal = 0
        
        for result in Results
        {
            total += result.max_marks ?? 0
            securedTotal += result.secured_marks ?? 0
            
        }
        
        let average = CommonObject().getAverage(total: total, secured: securedTotal)
        
        lblTotalMarks.text = "\(securedTotal)"
        lblAvg.text = "\(average) %"
        
        lblRank.text = self.getRankByPercentage(percentage: average)
        
        
    }
    
    func getRankByPercentage(percentage:Int) -> String
    {
        var rank = ""

        if percentage >= 95 && percentage <= 100
        {
            rank = "A+"
        }
        else if percentage >= 90 && percentage < 95
        {
            rank = "A"
        }
        else if percentage >= 85 && percentage < 90
        {
            rank = "B+"
        }
        else if percentage >= 80 && percentage < 85
        {
            rank = "B"
        }
        else if percentage >= 75 && percentage < 80
        {
            rank = "C+"
        }
        else if percentage >= 70 && percentage < 75
        {
            rank = "C"
        }
        else if percentage >= 65 && percentage < 70
        {
            rank = "D+"
        }
        else if percentage >= 60 && percentage < 65
        {
            rank = "D"
        }
        else if percentage >= 55 && percentage < 60
        {
            rank = "E+"
        }
        else if percentage >= 50 && percentage < 55
        {
            rank = "E"
        }
        else
        {
            rank = "F"
        }
        
        return rank
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
extension ResultsViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblExamDetails
        {
            return arrExamTypes.count
        }
        else
        {
            return arrResults.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblExamDetails
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsExamTypesCell")!
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .white
            cell.textLabel?.textAlignment = .center
            
            cell.textLabel?.text = arrExamTypes[indexPath.row].name
            if cell.textLabel?.text == examTypeStr
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
        else
        {
            let cell = tblResults.dequeueReusableCell(withIdentifier: "ResultsTableViewCell") as! ResultsTableViewCell
            cell.backgroundColor = .clear
            cell.lblSub.text = arrResults[indexPath.row].subject
            cell.lblSub.textColor = .white
            cell.lblMaxMarks.textColor = .white
            cell.lblSecuredMarks.textColor = .white
            cell.lblMaxMarks.text = "\(arrResults[indexPath.row].max_marks ?? 0)"
            cell.lblSecuredMarks.text = "\(arrResults[indexPath.row].secured_marks ?? 0)"
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == tblExamDetails
        {
            self.stackResults.isHidden = true
            self.stackBottomResults.isHidden = true
            examTypeStr = ""
            examTypeID = 0
            
            btnSelectExamType.setTitle(arrExamTypes[indexPath.row].name, for: .normal)
            examTypeStr = arrExamTypes[indexPath.row].name!
            examTypeID = arrExamTypes[indexPath.row].id!
            UIView.animate(withDuration: 0.3) {
                
                self.tblExamDetails.isHidden = true
            }
            
            self.tblExamDetails.reloadData()
        }
        
    }
    
}

