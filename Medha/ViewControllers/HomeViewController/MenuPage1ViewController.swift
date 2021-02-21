//
//  MenuPage1ViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 20/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit
import CoreData



class MenuPage1ViewController: UIViewController {

    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
         
    }
    var dropDownLists : DefaultLists!
    
    @IBOutlet weak var collnMenuHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collnViewMenu: UICollectionView!
    
    var arrMenuItems = [MenuItem]()
    var arrMenuImages = [UIImage]()
    
    let numberOfCellsPerRow: CGFloat = 3.5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collnViewMenu.backgroundColor = .clear
        
        if userDetails[0].roles == Role.Student_Parent.rawValue
        {
            arrMenuItems =  [MenuItem.menu_Attendance, MenuItem.menu_Homework, MenuItem.menu_Calendar, MenuItem.menu_Worksheets, MenuItem.menu_Payments, MenuItem.menu_Results, MenuItem.menu_Subject_Info, MenuItem.Menu_Suggestions, MenuItem.menu_Complaints]
            arrMenuImages = [#imageLiteral(resourceName: "Attendance"),#imageLiteral(resourceName: "Hoemwork"),#imageLiteral(resourceName: "Calendar"),#imageLiteral(resourceName: "Worksheets"),#imageLiteral(resourceName: "Payments"),#imageLiteral(resourceName: "Results"),#imageLiteral(resourceName: "Subject Info"),#imageLiteral(resourceName: "Suggestions"),#imageLiteral(resourceName: "Complaints")]
        }
        else
        {
            arrMenuItems =  [MenuItem.menu_Attendance, MenuItem.menu_Homework, MenuItem.menu_Calendar, MenuItem.menu_Worksheets, MenuItem.menu_Results, MenuItem.Menu_Suggestions, MenuItem.menu_Complaints]
            arrMenuImages = [#imageLiteral(resourceName: "Attendance"),#imageLiteral(resourceName: "Hoemwork"),#imageLiteral(resourceName: "Calendar"),#imageLiteral(resourceName: "Worksheets"),#imageLiteral(resourceName: "Results"),#imageLiteral(resourceName: "Suggestions"),#imageLiteral(resourceName: "Complaints"),]
        }
        
       // collnViewMenu.layer.borderColor = UIColor.red.cgColor
      //  collnViewMenu.layer.borderWidth = 2
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segue_Complaints
        {
            let complaintsVC = segue.destination as! ComplaintsViewController
            complaintsVC.userData = userData
            if dropDownLists != nil
            {
                complaintsVC.arrComplaintsTypes = dropDownLists.complaints!
              //  complaintsVC.arrClassList = dropDownLists.classes!
              //  complaintsVC.arrSectionList = dropDownLists.sections!
            }
            
        }
        if segue.identifier == segue_Suggestions
        {
            let suggestionVC = segue.destination as! SuggestionViewController
            suggestionVC.userData = userData
            if dropDownLists != nil
             {
                suggestionVC.arrSuggestionTypes = dropDownLists.suggestions!
             //   suggestionVC.arrClassList = dropDownLists.classes!
               // suggestionVC.arrSectionList = dropDownLists.sections!
             }
            
        }
        if segue.identifier == segue_ShowSuggestionOrComplaints
        {
            let showSuggestionsVC = segue.destination as! ShowSuggestion_Complaints_VC
            showSuggestionsVC.userData = userData
            if dropDownLists != nil
             {
                if(sender as! Bool)
                {
                    showSuggestionsVC.arrSuggestionOrComplaintsTypes = dropDownLists.suggestions!
                    showSuggestionsVC.isSuggestion = true
                    showSuggestionsVC.arrClassList = dropDownLists.classes!
                    showSuggestionsVC.arrSectionList = dropDownLists.sections!
                    showSuggestionsVC.strTitle = "Suggestions"
                }
                else
                {
                    showSuggestionsVC.arrSuggestionOrComplaintsTypes = dropDownLists.complaints!
                    showSuggestionsVC.isSuggestion = false
                    showSuggestionsVC.arrClassList = dropDownLists.classes!
                    showSuggestionsVC.arrSectionList = dropDownLists.sections!
                    showSuggestionsVC.strTitle = "Complaints"
                }

             }
            
        }
        if segue.identifier == segue_Homework
        {
            let HWVC = segue.destination as! HomeworkViewController
            HWVC.userData = userData
            if dropDownLists != nil
            {
               // HWVC.arrClasses = dropDownLists.classes!
                HWVC.arrSubjects_Students = dropDownLists.subjects!
                //HWVC.arrSection = dropDownLists.sections!
            }
            
        }
        if segue.identifier == segue_Payments
        {
            let PaymentsVC = segue.destination as! PaymentsViewController
            PaymentsVC.userData = userData
            if dropDownLists != nil
            {
                // HWVC.arrClasses = dropDownLists.classes!
                PaymentsVC.arrFeeTypes = dropDownLists.fees_details!
                //HWVC.arrSection = dropDownLists.sections!
            }
            
        }
        if segue.identifier == segue_Calendar
        {
            let CalVC = segue.destination as! CalendarViewController
            CalVC.userData = userData            
        }
        if segue.identifier == segue_Worksheets
        {
            let worksheetsVC = segue.destination as! WorksheetsViewController
            worksheetsVC.userData = userData
            if dropDownLists != nil
            {
//                worksheetsVC.arrClassList = dropDownLists.classes!
                worksheetsVC.arrSubjects_Student = dropDownLists.subjects!
//                worksheetsVC.arrSectionList = dropDownLists.sections!
            }
        }
        if segue.identifier == segue_SubjectInfo
        {
            let SubjectInfo = segue.destination as! SubjectInfoViewController
            SubjectInfo.userData = userData
            if dropDownLists != nil
            {
                SubjectInfo.arrClassList = dropDownLists.classes!
                SubjectInfo.arrSubjects = dropDownLists.subjects!
                SubjectInfo.arrSectionList = dropDownLists.sections!
            }
        }
        if segue.identifier == segue_Attendance_Teacher
        {
            let UpdateAttendanceVC = segue.destination as! updateAttendanceViewController
            UpdateAttendanceVC.userData = userData
//            if dropDownLists != nil
//            {
//                UpdateAttendanceVC.arrClasses = dropDownLists.classes!
//                UpdateAttendanceVC.arrSubjects = dropDownLists.subjects!
//                UpdateAttendanceVC.arrSection = dropDownLists.sections!
//            }
            
        }
        if segue.identifier == segue_Attendance
        {
            let AttendanceVC = segue.destination as! AttendanceViewController
            AttendanceVC.userData = userData
//            if dropDownLists != nil
//            {
//                UpdateAttendanceVC.arrClasses = dropDownLists.classes!
//                UpdateAttendanceVC.arrSubjects = dropDownLists.subjects!
//                UpdateAttendanceVC.arrSection = dropDownLists.sections!
//            }
            
        }
        if segue.identifier == segue_Results
        {
            let ResultsVC = segue.destination as! ResultsViewController
            ResultsVC.userData = userData
            if dropDownLists != nil
            {
                ResultsVC.arrSubjects = dropDownLists.subjects!
                ResultsVC.arrExamTypes = dropDownLists.exam_details!
            }
            
        }
        if segue.identifier == segue_Results_Teacher
        {
            let ResultsTeacherVC = segue.destination as! Results_TeacherViewController
            ResultsTeacherVC.userData = userData
            if dropDownLists != nil
            {
              //  ResultsTeacherVC.arrSubjects = dropDownLists.subjects!
              //  ResultsTeacherVC.arrClassList = dropDownLists.classes!
              //  ResultsTeacherVC.arrSectionList = dropDownLists.sections!
                ResultsTeacherVC.arrExamTypes = dropDownLists.exam_details!
            }
            
        }
        
        
    }
}
extension MenuPage1ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrMenuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeMenuCollectionViewCell", for: indexPath) as! HomeMenuCollectionViewCell
            
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        cell.layer.cornerRadius = 10
        
        cell.lblMenuName.text = arrMenuItems[indexPath.row].rawValue
        cell.imgMenu.image = arrMenuImages[indexPath.row]
        
        if cell.lblMenuName.text == "Attendance"
        {
            cell.lblBadge.isHidden = true
            cell.lblBadge.layer.cornerRadius = cell.lblBadge.frame.height/2
            cell.lblBadge.clipsToBounds = true
            cell.lblBadge.backgroundColor = .red
            cell.lblBadge.text = "2"
        }
        else
        {
            cell.lblBadge.isHidden = true
        }
        
       return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 95, height: 90)
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width / numberOfCellsPerRow
        
        let height = collectionView.frame.size.width  / numberOfCellsPerRow
        
        return CGSize(width: width-10, height: height-20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! HomeMenuCollectionViewCell

        let menuSelected = cell.lblMenuName.text
        
        let selectedItem = MenuItem(rawValue: menuSelected!)
        
        switch selectedItem {
        case .menu_Attendance:
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                self.performSegue(withIdentifier: segue_Attendance, sender: nil)
              
            }
            else
            {
                 self.performSegue(withIdentifier: segue_Attendance_Teacher, sender: nil)
            }
            break
        case .menu_Homework:
              self.performSegue(withIdentifier: segue_Homework, sender: nil)
            break
        case .menu_Calendar:
             self.performSegue(withIdentifier: segue_Calendar, sender: nil)
            break
        case .menu_Worksheets:
            self.performSegue(withIdentifier: segue_Worksheets, sender: nil)
            break
        case .menu_Payments:
            self.performSegue(withIdentifier: segue_Payments, sender: nil)
            break
        case .menu_Results:
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                self.performSegue(withIdentifier: segue_Results, sender: nil)
            }
            else
            {
                self.performSegue(withIdentifier: segue_Results_Teacher, sender: nil)
            }
            break
        case .menu_Subject_Info:
             self.performSegue(withIdentifier: segue_SubjectInfo, sender: nil)
            break
        case .Menu_Suggestions:
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                 self.performSegue(withIdentifier: segue_Suggestions, sender: nil)
            }
            else
            {
              
                self.performSegue(withIdentifier: segue_ShowSuggestionOrComplaints, sender: true)
            }
            break
        case .menu_Complaints:
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                self.performSegue(withIdentifier: segue_Complaints, sender: nil)
                
            }
            else
            {
              
                self.performSegue(withIdentifier: segue_ShowSuggestionOrComplaints, sender: false)
            }
            break

        default:
            AlertView.shared.showAlert(message: "Will be available soon", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])

            break
        }
        
     /*
        switch indexPath.row {
        case 0:
            
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                self.performSegue(withIdentifier: segue_Attendance, sender: nil)
              
            }
            else
            {
                 self.performSegue(withIdentifier: segue_Attendance_Teacher, sender: nil)
            }
 
        case 1:
            self.performSegue(withIdentifier: segue_Homework, sender: nil)
        case 3:
            self.performSegue(withIdentifier: segue_Worksheets, sender: nil)
        case 4:
            self.performSegue(withIdentifier: segue_Payments, sender: nil)
        case 5:
            
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                self.performSegue(withIdentifier: segue_Results, sender: nil)
            }
            else
            {
                self.performSegue(withIdentifier: segue_Results_Teacher, sender: nil)
            }
            
        case 6:
            self.performSegue(withIdentifier: segue_SubjectInfo, sender: nil)
        case 7:
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                 self.performSegue(withIdentifier: segue_Suggestions, sender: nil)
            }
            else
            {
              
                self.performSegue(withIdentifier: segue_ShowSuggestionOrComplaints, sender: true)
            }
            
        case 8:
            
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                self.performSegue(withIdentifier: segue_Complaints, sender: nil)
                
            }
            else
            {
              
                self.performSegue(withIdentifier: segue_ShowSuggestionOrComplaints, sender: false)
            }
            
        default:
            
            AlertView.shared.showAlert(message: "Will be available soon", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            
        }
        */
        
    }

}
