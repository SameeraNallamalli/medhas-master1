//
//  LeftMenuViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 02/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit
import CoreData

class LeftMenuViewController: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var tblMenuItems: UITableView!
    
    let arrMenuItems = ["Profile","School Contact Details","Advertisements","School Images"]
    var userData : LoginDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuItems.backgroundColor = .clear
        tblMenuItems.tableFooterView = UIView()
        profileImg.layer.cornerRadius = 30
        profileImg.clipsToBounds = true
        lblUserName.text = ""
        self.fetchProfileDataAndUpdateView()
    }
    override func viewDidLayoutSubviews(){
        
        if tblMenuItems.contentSize.height < tblMenuItems.frame.size.height
        {
            tblMenuItems.frame = CGRect(x: tblMenuItems.frame.origin.x, y: tblMenuItems.frame.origin.y, width: tblMenuItems.frame.size.width, height: tblMenuItems.contentSize.height)
            tblMenuItems.reloadData()
        }
    }
    
    func fetchProfileDataAndUpdateView()
    {
        let profileData = DBManager.shared.fetch(entity: ProfileData.self, showAlertForErrorIn: self) as? [ProfileData]
        
        if profileData!.count > 0
        {
            userData = profileData![0].model as? LoginDetails
            
            let details = userData.details![0]
            
            lblUserName.text = details.fullname
            profileImg.loadImageUsingCache(withUrl: details.profile_pic ?? "")
            
            
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == segue_Profile
        {
            let profileVC = segue.destination as! ProfileEditViewController
            
            profileVC.strTitle = sender as! String
            profileVC.userData = userData
            
        }
        if segue.identifier == segue_ContactUs
        {
            let contactsVC = segue.destination as! ContactDetailsViewController
            
            contactsVC.strTitle = sender as! String
            
        }
        if segue.identifier == segue_SchoolImgTypes
        {
            let schoolImagesVC = segue.destination as! SchoolImgTypesViewController
            
            schoolImagesVC.strTitle = sender as! String
            
        }
        
    }


}
extension LeftMenuViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tblMenuItems.dequeueReusableCell(withIdentifier: "SideMenuCell")

            cell?.textLabel?.text = arrMenuItems[indexPath.row]
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
            return cell!

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
             self.performSegue(withIdentifier: segue_Profile, sender: arrMenuItems[indexPath.row])
        case 1:
            self.performSegue(withIdentifier: segue_ContactUs, sender: arrMenuItems[indexPath.row])
        case 2:
          //  self.performSegue(withIdentifier: segue_Profile, sender: arrMenuItems[indexPath.row])
            AlertView.shared.showAlert(message: "Will available on next", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            
        case 3:
            self.performSegue(withIdentifier: segue_SchoolImgTypes, sender: arrMenuItems[indexPath.row])
        default:
            break
        }
        
       
        
    }
    
}
