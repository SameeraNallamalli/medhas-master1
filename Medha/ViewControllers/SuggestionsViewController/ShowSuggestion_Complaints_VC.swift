//
//  ShowSuggestionViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 15/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit

class ShowSuggestion_Complaints_VC: UIViewController {

    @IBOutlet weak var tblSuggestions: UITableView!
    @IBOutlet weak var btnAdd: UIBarButtonItem!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var strTitle = ""
    var isSuggestion = true
    var arrSuggestionsOrComplaints = [SuggestionDetails]()
    var arrSuggestionOrComplaintsTypes = [defaultList]()
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
         
    }
    var isLoadMore = false
    var arrClassList = [defaultList]()
    var arrSectionList = [defaultList]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addGradientBGColor()
        self.title = strTitle
        tblSuggestions.addAppearanceWith(isHide: false)
        
        CommonObject().showHUD()
        lblError.text = ""
        
        if isSuggestion
        {
            self.getSuggestionsData()
        }
        else
        {
            self.getComplaintsData()
        }
        
    }
    
    /*
     
     if segue.identifier == segue_Complaints
     {
         let complaintsVC = segue.destination as! ComplaintsViewController
         complaintsVC.userData = userData
         if dropDownLists != nil
         {
             complaintsVC.arrComplaintsTypes = dropDownLists.complaints!
         }
         
     }
     if segue.identifier == segue_Suggestions
     {
         let suggestionVC = segue.destination as! SuggestionViewController
         suggestionVC.userData = userData
         if dropDownLists != nil
          {
              suggestionVC.arrSuggestionTypes = dropDownLists.suggestions!
            //  HWVC.arrSubjects = dropDownLists.subjects!
          }
         
     }
     
     
     */
    
    @IBAction func btnAddClicked(_ sender: UIBarButtonItem)
    {
        if isSuggestion
        {
            let AddSuggestionVC = MainSB.instantiateViewController(withIdentifier: "SuggestionViewController") as! SuggestionViewController
            AddSuggestionVC.userData = userData
            AddSuggestionVC.arrSuggestionTypes = arrSuggestionOrComplaintsTypes
         //   AddSuggestionVC.arrClassList = arrClassList
          //  AddSuggestionVC.arrSectionList = arrSectionList
            let navController = UINavigationController(rootViewController: AddSuggestionVC)
            self.present(navController, animated: true, completion: nil)
        }
        else
        {
            let AddComplaintsVC = MainSB.instantiateViewController(withIdentifier: "ComplaintsViewController") as! ComplaintsViewController
            AddComplaintsVC.userData = userData
            AddComplaintsVC.arrComplaintsTypes = arrSuggestionOrComplaintsTypes
           // AddComplaintsVC.arrClassList = arrClassList
           // AddComplaintsVC.arrSectionList = arrSectionList
            let navController = UINavigationController(rootViewController: AddComplaintsVC)
            self.present(navController, animated: true, completion: nil)
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
        tblSuggestions.reloadSections(sections, with: .fade)
    }
    
    func getSuggestionsData()
    {
      let parmsDict = ["id":userDetails[0].id ?? 0] as [String : Any]

    
       CommonObject().getDataFromServer(urlString: getSuggestions, method: .POST, model: Suggestions.self, paramsDict: parmsDict) { (data, resp, err) in
         
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
                DispatchQueue.main.async {
                    
                    if data?.details?.count ?? 0 > 0
                    {
                        self.arrSuggestionsOrComplaints = (data?.details)!
//                        self.arrSuggestionsOrComplaints = self.arrSuggestionsOrComplaints.filter({$0.id == self.userDetails[0].id})
                        self.tblSuggestions.reloadData()
                        self.lblError.isHidden = true
//                        if self.arrSuggestionsOrComplaints.count == 0
//                        {
//                            self.lblError.text = Alert_NoSuggestions
//                            self.lblError.isHidden = false
//
//                            return
//                        }
                    }
                    else
                    {
                        self.lblError.text = Alert_NoSuggestions
                        self.lblError.isHidden = false
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
    
    func getComplaintsData()
    {
               
        let parmsDict = ["id":userDetails[0].id ?? 0] as [String : Any]
        
        CommonObject().getDataFromServer(urlString: getComplaints, method: .POST, model: Suggestions.self, paramsDict: parmsDict) { (data, resp, err) in
          
          if err == nil && resp != nil
          {
              print(data!)
              if data?.status == "error"
              {
                  DispatchQueue.main.async {
                   
                      AlertView.shared.showAlert(message: data?.msg ?? "", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                  }
              }
              else if data?.status == "success"
              {
                // Do with data
                 DispatchQueue.main.async {
                     if data?.details?.count ?? 0 > 0
                     {
                        self.arrSuggestionsOrComplaints = (data?.details)!
//                        self.arrSuggestionsOrComplaints = self.arrSuggestionsOrComplaints.filter({$0.id == self.userDetails[0].id})
//
//                        if self.arrSuggestionsOrComplaints.count == 0
//                        {
//                            self.lblError.text = Alert_NoComplaints
//                            self.lblError.isHidden = false
//                            return
//                        }
                        self.tblSuggestions.reloadData()
                        self.lblError.isHidden = true
                     }
                    else
                     {
                        self.lblError.text = Alert_NoComplaints
                        self.lblError.isHidden = false
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ShowSuggestion_Complaints_VC : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSuggestionsOrComplaints.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tblSuggestions.dequeueReusableCell(withIdentifier: "SuggestionsTableViewCell") as! SuggestionsTableViewCell
        
        cell.backgroundColor = .clear
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 0.5
        
        cell.lblDate.text = arrSuggestionsOrComplaints[indexPath.section].submitted_date?.toDate(Format: DF_dd_MM_yyyy)
        cell.lblName.text = arrSuggestionsOrComplaints[indexPath.section].full_name
        cell.lblClass.isHidden = true
        cell.lblSection.isHidden = true
        
      //  cell.lblClass.text = "Class : \(arrSuggestionsOrComplaints[indexPath.section].class!)"
        //cell.lblSection.text = "Section : \(arrSuggestionsOrComplaints[indexPath.section].section!)"
        cell.lblCategory.text = arrSuggestionsOrComplaints[indexPath.section].area!
        cell.lblMessage.text = arrSuggestionsOrComplaints[indexPath.section].content!
        
        let msgNumberOfLines = cell.lblMessage.maxNumberOfLines
       // print("Number of lines : \(cell.lblMessage.maxNumberOfLines)")
        
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
        
    }
    
}
