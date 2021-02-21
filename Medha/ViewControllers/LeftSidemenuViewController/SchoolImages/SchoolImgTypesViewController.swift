//
//  SchoolImagesViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 05/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit

class SchoolImgTypesViewController: UIViewController {
    
    @IBOutlet weak var tblSchoolImgTypes: UITableView!
    
    var strTitle = ""
    let arrSchoolImgTypes = ["All","Class Rooms","Play Grounds","Library","Canteen","Lab","Others"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = strTitle
         self.addGradientBGColor()
        tblSchoolImgTypes.addAppearanceWith(isHide: false)
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let imagesVC = segue.destination as! SchoolImgesViewController
        imagesVC.strTitle = sender as! String
        
    }

    
    @objc func btnCellContentDetailsClicked(sender:UIButton)
    {
        sender.showsTouchWhenHighlighted = true
    }

}
extension SchoolImgTypesViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrSchoolImgTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tblSchoolImgTypes.dequeueReusableCell(withIdentifier: "SchoolImagesCell")

        cell?.textLabel?.text = arrSchoolImgTypes[indexPath.row]
        cell?.backgroundColor = .clear
        cell?.textLabel?.textColor = .white
         //add button as accessory view
         let cellContentDetails = UIButton(type: .custom)
         cellContentDetails.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
         cellContentDetails.addTarget(self, action: #selector(self.btnCellContentDetailsClicked(sender:)), for: .touchUpInside)
         let btnImage = #imageLiteral(resourceName: "NextArrow")
         cellContentDetails.setImage(btnImage, for: .normal)
        // cellContentDetails.setTitle("View", for: .normal)
         cellContentDetails.contentMode = .scaleAspectFit
         cellContentDetails.tag = indexPath.row
         cell?.accessoryView = cellContentDetails as UIView
         cell?.accessoryType = .detailButton
         cell?.tintColor = .orange

        return cell!

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.performSegue(withIdentifier: segue_SchoolImages, sender: arrSchoolImgTypes[indexPath.row])

    }
    
}
