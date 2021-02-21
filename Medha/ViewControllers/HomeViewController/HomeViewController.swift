//
//  HomeViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 01/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit
import CoreData
import SideMenu

class HomeViewController: UIViewController {
    
    @IBOutlet weak var lblNameTitle: UILabel!
    @IBOutlet weak var lblRollNumberTitle: UILabel!
    @IBOutlet weak var lblClassTitle: UILabel!
    @IBOutlet weak var lblUserIDTitle: UILabel!
    @IBOutlet weak var stackRollNumber: UIStackView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUserID: UILabel!
    @IBOutlet weak var lblRollNumber: UILabel!
    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnSignOut: UIBarButtonItem!
    @IBOutlet weak var btnMenuPage1: UIButton!
    @IBOutlet weak var btnMenuPage2: UIButton!
    @IBOutlet weak var lblMarquee: UILabel!
    @IBOutlet weak var btnMarquee: UIButton!
    @IBOutlet weak var stackUserDetails: UIStackView!
    @IBOutlet weak var btnExtra: UIButton!
    
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
         
    }
    
    var container: ContainerViewController!
    var menuPage = Int()
    var arrDropDownList : DefaultLists!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.fetchProfileDataAndUpdate()
        self.navigationController?.addCustomBottomLine(color:UIColor.orange, height: 0.7)
        menuPage = 1
        self.btnMenuPage1.isEnabled = false
        self.addGradientBGColor()
        btnMarquee.isHidden = true
        lblMarquee.text = "School will be reopen on July 10th, 2020"
        lblMarquee.textColor = .white
        
       // self.stackUserDetails.addBackground(withBGColor: UIColor.white.withAlphaComponent(0.3), borderColor: .white)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

      //  NotificationCenter.default.addObserver(self, selector: #selector(NotificationObserverClicks(notification:)), name: .swipedLeft, object: nil)
      //  NotificationCenter.default.addObserver(self, selector: #selector(NotificationObserverClicks(notification:)), name: .swipedRight, object: nil)

        UIView.animate(withDuration: 9.0, delay: 0.0, options: [.curveLinear,.repeat], animations: { () -> Void in
            self.lblMarquee.frame = CGRect(x: -(screenWidth), y: self.lblMarquee.frame.origin.y, width: screenWidth, height: 22)
        }, completion: { (finished: Bool) -> Void in
            self.lblMarquee.frame = CGRect(x: screenWidth , y: self.lblMarquee.frame.origin.y, width: screenWidth, height: 22)
        });
        
        btnExtra.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        btnExtra.layer.cornerRadius = 10
        
        self.fetchDropDownLists()
        self.fetchProfileData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .swipedRight, object: nil)
        NotificationCenter.default.removeObserver(self, name: .swipedLeft, object: nil)
        
        self.lblMarquee.layer.removeAllAnimations()
    }
    func fetchDropDownLists()
    {
        let dropdownData = DBManager.shared.fetch(entity: DropDownLists.self, showAlertForErrorIn: self) as? [DropDownLists]
        
        if dropdownData!.count > 0
        {
            let lists = dropdownData![0].model as! DefaultLists
            arrDropDownList = lists
        }

    }
    func fetchProfileData()
    {
        let request : NSFetchRequest<ProfileData>
        request = ProfileData.fetchRequest()
        do
        {
            let results = try context.fetch(request)
            
            if results.count > 0
            {
                let profile = results[0].model as! LoginDetails
                userData = profile
            }
        }
        catch let err
        {
            print(err.localizedDescription)
        }
    }
    
    @objc func NotificationObserverClicks(notification:NSNotification)
    {
        
        if notification.name == .swipedRight
        {
            self.btnPrevClicked(self.btnMenuPage2)
                    }
        else if notification.name == .swipedLeft
        {
             self.btnNextClicked(self.btnMenuPage1)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .default
    }
    
    
    @IBAction func menuPageControlClicked(_ sender: UIPageControl)
    {
        switch sender.currentPage {
        case 0:
            self.btnPrevClicked(btnMenuPage1)
        case 1:
            self.btnNextClicked(btnMenuPage2)
        default:
            break
        }
        
    }
    @IBAction func btnSignOut(_ sender: UIBarButtonItem)
    {
        AlertView.shared.showAlert(message: Alert_Confirm_LogOut, toView: self, ButtonTitles: ["Logout","Cancel"], ButtonActions: [
            { LogoutClicked in
                CommonObject().showHUD()
                DBManager.shared.Delete(entity: ProfileData.self, showAlertForErrorIn: self) { (status) in
                    
                    if status
                    {
                        DBManager.shared.Delete(entity: DropDownLists.self, showAlertForErrorIn: self) { (status) in
                            
                            if status
                            {
                                self.dismiss(animated: true, completion: nil)
                                UserDefaults.standard.removeObject(forKey: "profAddress")
                                let loginVC = MainSB.instantiateViewController(withIdentifier: "LoginViewController")
                                let navigationController = UINavigationController.init(rootViewController: loginVC)
                                let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                                appDel.window?.rootViewController = navigationController
                                CommonObject().dismisHUD()
                            }
                        }
                    }
                }
            },
            { CancelClicked in
                self.dismiss(animated: true, completion: nil)
            },
           
            nil ])
        
//        let request : NSFetchRequest<ProfileData>
//        request = ProfileData.fetchRequest()
//        do
//        {
//            let results = try context.fetch(request)
//
//            if results.count > 0
//            {
//                for item in results
//                {
//                    context.delete(item)
//                }
//
//                do
//                {
//                   try context.save()
//
//                    let loginVC = MainSB.instantiateViewController(withIdentifier: "LoginViewController")
//                    let navigationController = UINavigationController.init(rootViewController: loginVC)
//                    let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//                    appDel.window?.rootViewController = navigationController
//                }
//                catch let err {
//                    print(err.localizedDescription)
//                }
//
//           }
//
//        }
//        catch let err
//        {
//           print(err.localizedDescription)
//        }
        
    }
    @IBAction func imgTapped(_ sender: UITapGestureRecognizer)
    {
        
        print("tapped")
    }
    
    @IBAction func btnExtraClicked(_ sender: UIButton)
    {
        
        let menu2VC = MainSB.instantiateViewController(withIdentifier: "MenuPage2ViewController") as! MenuPage2ViewController
        menu2VC.userData = userData
        menu2VC.dropDownLists = arrDropDownList
        self.navigationController?.pushViewController(menu2VC, animated: true)
        
    }
    
    @IBAction func btnProfileClicked(_ sender: UIButton)
    {

    }
    
    @IBAction func btnPrevClicked(_ sender: UIButton)
    {
        if menuPage == 2
        {
            container!.segueIdentifierReceivedFromParent("menuPage1", segue: .fromLeft)
            self.btnMenuPage1.isEnabled = false
            self.btnMenuPage2.isEnabled = true
            menuPage = 1
        }
       
    }
    
    @IBAction func btnNextClicked(_ sender: UIButton)
    {
        if menuPage == 1
        {
            container!.segueIdentifierReceivedFromParent("menuPage2", segue: .fromRight)
            self.btnMenuPage2.isEnabled = false
            self.btnMenuPage1.isEnabled = true
            menuPage = 2
        }
        
    }
    
    
    func fetchProfileDataAndUpdate()
    {
        
        let profileData = DBManager.shared.fetch(entity: ProfileData.self, showAlertForErrorIn: self) as? [ProfileData]
        
        if profileData!.count > 0
        {
            let profile = profileData![0].model as! LoginDetails
            userDetails = profile.details!
            self.updateUserData(profile: profile)
        }

        /*
        let request : NSFetchRequest<ProfileData>
        request = ProfileData.fetchRequest()
        do
        {
            let results = try context.fetch(request)
            
            if results.count > 0
            {
                let profile = results[0].model as! LoginDetails
                userDetails = profile
                self.updateUserData(profile: profile)
            }
        }
        catch let err
        {
            print(err.localizedDescription)
        }
 */
    }
    
    func updateUserData(profile:LoginDetails)
    {

        let details = profile.details![0]
        self.lblName.text = ": \(details.fullname!)"
        
      //  self.lblUserID.text = "User ID : " + "\(details.id ?? 000)"
       // let randomNumber = arc4random()
    //    self.lblRollNumber.text = "Roll Number : " + "\(details.register_num ?? "000")"
    //    self.lblClass.text = "Class : " + "\(details.class_education ?? "0")"
        self.imgProfile.loadImageUsingCache(withUrl: details.profile_pic ?? "")
        self.imgProfile.layer.cornerRadius = 30
        self.imgProfile.clipsToBounds = true
        
        if userDetails[0].roles == Role.Student_Parent.rawValue
        {
         //   let intSection = Int(details.section ?? "0")
            
         //   let char = Character(UnicodeScalar(Int(UnicodeScalar("A").value) + intSection! - 1)!)

          //  self.lblUserID.text = "Section : " + "\(((intSection)!-1).correspondingLetter(inUppercase: true) ?? "0")"
            self.lblUserIDTitle.text = "Section"
            
            self.lblUserID.text = ": \(details.section_name ?? "")"
            self.lblRollNumber.text = ": \(details.register_num ?? "000")"
           // let intClass = Int(details.class_education ?? "0")
           // self.lblClass.text = "Class : " + "\(intClass?.romanNumeral ?? "0")"
            self.lblClass.text = ": \(details.class_name ?? "")"
            
        }
        else
        {
            self.lblClassTitle.text = "Qualification"
            self.lblClass.text = ": \(details.qualification_name ?? "")"
            self.lblUserIDTitle.text = "Registration ID"
            self.lblUserID.text = ": \(details.register_num ?? "000")"
           // self.stackRollNumber.isHidden = true
            self.lblRollNumber.isHidden = true
            self.lblRollNumberTitle.isHidden = true
            
           // self.lblClass.isHidden = true
        }
    }
    
    private func makeSettings() -> SideMenuSettings {
         var settings = SideMenuSettings()
        settings.presentationStyle = .menuSlideIn
        settings.blurEffectStyle = .dark
        settings.menuWidth = screenWidth - 100
        settings.statusBarEndAlpha = 0
        SideMenuManager.default.leftMenuNavigationController?.settings = settings

        return settings
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            container = segue.destination as? ContainerViewController
            
           // container.userData = userDetails
            //For adding animation to the transition of containerviews you can use container's object property
            // animationDurationWithOptions and pass in the time duration and transition animation option as a tuple
            // Animations that can be used
            // .transitionFlipFromLeft, .transitionFlipFromRight, .transitionCurlUp
            // .transitionCurlDown, .transitionCrossDissolve, .transitionFlipFromTop
           // container.animationDurationWithOptions = (0.5, .transitionFlipFromTop)
        }
        else
        {
            guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
            sideMenuNavigationController.settings = makeSettings()
        }
    }
 
}

