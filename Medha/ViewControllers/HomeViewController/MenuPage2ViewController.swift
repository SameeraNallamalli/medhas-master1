//
//  MenuPage2ViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 21/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit
import CoreData

class MenuPage2ViewController: UIViewController {
    
    @IBOutlet weak var collnViewMenu: UICollectionView!
    
    let arrMenuItems = [MenuItem.menu_Tutorials,MenuItem.menu_Personality_Development]
    let arrMenuImages = [#imageLiteral(resourceName: "Tutorials"),#imageLiteral(resourceName: "Personality Developement")]
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
         
    }
    
    var dropDownLists : DefaultLists!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addGradientBGColor()
        self.collnViewMenu.backgroundColor = .clear
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segue_Tutorials
        {
            let tutorialVC = segue.destination as! TutorialsViewController
             tutorialVC.userData = userData
            if dropDownLists != nil
            {
                tutorialVC.arrTutorialTypes = dropDownLists.tutorials!
              //  tutorialVC.arrClassTypes = dropDownLists.classes!
            }
            
        }
        if segue.identifier == segue_PD
        {
            let PDVC = segue.destination as! PDViewController
            PDVC.userData = userData
            if dropDownLists != nil
            {
                PDVC.arrPDTypes = dropDownLists.personality_development!
            }
            
        }
        if segue.identifier == segue_PDDetails
        {
            let details = segue.destination as! Show_PD_TutorialsViewController
             details.userData = userData
          //  if dropDownLists != nil
        //    {
                if(sender as! Bool)
                {
                    details.strTitle = "Personality Development"
                    details.isPDDetails = true
                }
                else
                {
                     details.strTitle = "Tutorials"
                    details.isPDDetails = false
                    
                }
                
              
          //  }
            
        }

    }


}
extension MenuPage2ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
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
        
       return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width
        
        let height = collectionView.frame.size.height / 2
        
        return CGSize(width: width-20, height: height-20)
        
        
        //return CGSize(width: screenWidth - 50, height: (screenHeight/2)-50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath) as! HomeMenuCollectionViewCell

        let menuSelected = cell.lblMenuName.text
        
        let selectedItem = MenuItem(rawValue: menuSelected!)
        
        switch selectedItem {
        case .menu_Tutorials:
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                self.performSegue(withIdentifier:segue_PDDetails, sender: false)
            }
            else
            {
                self.performSegue(withIdentifier:segue_Tutorials, sender: nil)
            }
            break
        case .menu_Personality_Development:
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                self.performSegue(withIdentifier:segue_PDDetails, sender: true)
            }
            else
            {
                self.performSegue(withIdentifier:segue_PD, sender: nil)
            }
            break
        default:
            break
        }
        
    }

}
