//
//  HomeworkViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 07/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit
import FSCalendar
import Photos

class HomeworkViewController: UIViewController {
    
    @IBOutlet weak var HWCalender: FSCalendar!
    @IBOutlet weak var lblSelectedDate: UILabel!
    @IBOutlet weak var lblSelectedDay: UILabel!
    @IBOutlet weak var btnSelectSubject: UIButton!
    @IBOutlet weak var tblSujects: UITableView!
    @IBOutlet weak var stackSelectedDate: UIStackView!
    @IBOutlet weak var stackAddAndUpload: UIStackView!
    @IBOutlet weak var btnSelectClass: UIButton!
    @IBOutlet weak var tblClassList: UITableView!
    @IBOutlet weak var stackSubject: UIStackView!
    @IBOutlet weak var stackClassAndSection: UIStackView!
    @IBOutlet weak var btnSelectSection: UIButton!
    @IBOutlet weak var tblSectionList: UITableView!
    @IBOutlet weak var stackClass: UIStackView!
    @IBOutlet weak var stackSection: UIStackView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtViewWork: UITextView!
    @IBOutlet weak var collnHWImages: UICollectionView!
    @IBOutlet weak var txtVwHConstraint: NSLayoutConstraint!
    
    var arrSubjects = [TeacherHandled]()
    var arrSection = [TeacherHandled]()
    var arrClasses = [TeacherHandled]()
    var arrSubjects_Students = [defaultList]()
    
    var arrHW_iamges = [UIImage]()
    var arrHW_Urls = [URL]()
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
         
    }
    
    var strSelectedSub = ""
    var strSelectedSection = ""
    var strSelectedClass = ""
    
    var selectedSubID = 0
    var selectedSectionID = 0
    var selectedClassID = 0
    var strHWDate = ""
    var isContentOrImgAvailable = false
    
    let numberOfCellsPerRow : CGFloat = 3
    
    var imagePicker: UIImagePickerController!
    
    var arrHomeWork = [CommonDetails]()
    var arrSubClassHandled = [SubClassHandled]()
    
    @IBOutlet weak var subjectHConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var classHConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sectionHConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addGradientBGColor()
        self.calendarAppearance()
        tblClassList.addAppearanceWith(isHide: true)
        tblSujects.addAppearanceWith(isHide: true)
        tblSectionList.addAppearanceWith(isHide: true)
        self.buttonAppearance()
        self.textViewAppearance()
        txtViewWork.addBorder()
        stackSelectedDate.isHidden = true
        self.lblSelectedDate.text = ""
        collnHWImages.isHidden = false
        collnHWImages.backgroundColor = .clear
      //  collnHWImages.layer.borderColor = UIColor.white.cgColor
      //  collnHWImages.layer.borderWidth = 1

        
        if userDetails[0].roles == Role.Student_Parent.rawValue
        {
            btnUpload.isHidden = true
            btnAdd.setTitle("Show Homework", for: .normal)
            btnSubmit.isHidden = true
         //   btnSelectClass.isHidden = true
           // btnSelectSection.isHidden = true
            stackClassAndSection.isHidden = true
            
            strSelectedClass = userDetails[0].class_education ?? ""
            selectedClassID = Int(userDetails[0].class_education ?? "0") ?? 0
            
            strSelectedSection = userDetails[0].section ?? ""
            selectedSectionID = Int(userDetails[0].section ?? "0") ?? 0
         
        }
        else
        {
            btnUpload.isHidden = false
            btnAdd.setTitle("Add", for: .normal)
            btnSubmit.isHidden = false
            
            arrSubClassHandled = userDetails[0].subj_class_handled!
            
            for subSecion in arrSubClassHandled
            {
                let subInfo = TeacherHandled(name: subSecion.subject_name, id: Int(subSecion.subject_id!))
                arrSubjects.append(subInfo)
                
                let classInfo = TeacherHandled(name: subSecion.class_name, id: Int(subSecion.class_id!))
                arrClasses.append(classInfo)
                
                let sectionInfo = TeacherHandled(name: subSecion.section_name, id: Int(subSecion.section_id!))
                arrSection.append(sectionInfo)
                
            }
            
            arrSubjects = arrSubjects.uniqueValues(value: {$0.id!})
            arrClasses = arrClasses.uniqueValues(value: {$0.id!})
            arrSection = arrSection.uniqueValues(value: {$0.id!})
            
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if currentReachabilityStatus == .notReachable
        {
            AlertView.shared.showAlert(message: Alert_No_Internet, toView: self, ButtonTitles: ["OK"], ButtonActions: [{btnAction in
                
                let _ = self.navigationController?.popViewController(animated: true)
                
                },nil])
        }
        
    }
    
//    func getClassID_SectionID_From(strClass:String,strSection:String) -> (classID:Int,sectionID:Int)
//    {
//        var classID = 0
//        var sectionID = 0
//
//
//        let arrFilter = arrClasses.filter({$0.name == strClass})
//
//
//
//
//        return(classID,sectionID)
//    }
    
    
      override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
          
            if (self.tblClassList.contentSize.height < classHConstraint.constant)
            {
                classHConstraint.constant = self.tblClassList.contentSize.height
            }

            if (self.tblSectionList.contentSize.height < sectionHConstraint.constant)
            {
                sectionHConstraint.constant = self.tblSectionList.contentSize.height
            }

            if (self.tblSujects.contentSize.height < subjectHConstraint.constant)
            {
                subjectHConstraint.constant = self.tblSujects.contentSize.height
            }
          
      }
  
    func textViewAppearance()
    {
        self.txtViewWork.isHidden = true
        self.txtViewWork.backgroundColor = .clear
        self.txtViewWork.layer.borderColor = UIColor.white.cgColor
        self.txtViewWork.layer.borderWidth = 1.5
        self.txtViewWork.textColor = .white
        self.txtViewWork.tintColor = .white
       
    }

    func buttonAppearance()
    {
        self.btnSelectSubject.addColors(titleColor: .white, bgColor: .clear, borderColor:  ColorsConfig.footerColor.withAlphaComponent(0.5))
        self.btnSelectClass.addColors(titleColor: .white, bgColor: .clear, borderColor:  ColorsConfig.footerColor.withAlphaComponent(0.5))
        self.btnSelectSection.addColors(titleColor: .white, bgColor: .clear, borderColor:  ColorsConfig.footerColor.withAlphaComponent(0.5))
        self.btnAdd.addColors(titleColor: UIColor.white, bgColor: .clear, borderColor: .white)
        self.btnUpload.addColors(titleColor: UIColor.white, bgColor: .clear, borderColor: .white)
        self.btnSubmit.addColors(titleColor: UIColor.white, bgColor: .clear, borderColor: .white)
    }
    
    func calendarAppearance()
    {
        HWCalender.register(FSCalendarCell.self, forCellReuseIdentifier: "Cell")
        HWCalender.scope = .week
        //  myCalender.calendarHeaderView.isHidden = true
        HWCalender.allowsMultipleSelection = false
        HWCalender.backgroundColor = .clear
        
        HWCalender.appearance.weekdayTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        HWCalender.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18)
        HWCalender.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 14)
        HWCalender.appearance.headerTitleColor = .yellow
        HWCalender.appearance.titleFont = UIFont.boldSystemFont(ofSize: 14)
    }
        
    @IBAction func btnClassSelected(_ sender: UIButton)
    {
        if !(tblSujects.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSujects.isHidden = true
            }
        }
        
        if tblClassList.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClassList.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClassList.isHidden = true
            }
        }
         self.tblClassList.reloadData()
    }
    
    @IBAction func btnSectionSelectedClicked(_ sender: UIButton)
    {
        
        if !(tblClassList.isHidden)
        {
            UIView.animate(withDuration: 0.3) {

                self.tblClassList.isHidden = true
            }
        }
        if !(tblSujects.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSujects.isHidden = true
            }
        }
        
        if tblSectionList.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSectionList.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSectionList.isHidden = true
            }
        }
        
         self.tblSectionList.reloadData()
    }
    
    
    
    @IBAction func btnSubjectsSelected(_ sender: UIButton)
    {
                
        if !(tblClassList.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClassList.isHidden = true
            }
        }
        if !(tblSectionList.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSectionList.isHidden = true
            }
        }
        
        if tblSujects.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSujects.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSujects.isHidden = true
            }
        }
        
         self.tblSujects.reloadData()
    }
    
    @IBAction func btnAddClicked(_ sender: UIButton)
    {
        if sender.titleLabel?.text == "Add"
        {
            UIView.animate(withDuration: 0.3) {
                
                self.txtViewWork.isHidden = false
            }
        }
        else
        {
            self.getHomework()
        }


    }
    @IBAction func btnUploadClicked(_ sender: UIButton)
    {
        
        if arrHW_iamges.count < 3
        {
            let actionAlert = UIAlertController(title: nil, message: "Select source to upload photos", preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (cameraAction) in
                
               // self.collnHWImages.isHidden = false
                
                self.openCamera()
                
            }
            actionAlert.addAction(cameraAction)
            
            let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (galleryAction) in
                
              //  self.collnHWImages.isHidden = false
                
                self.openGallery()
            }
            
            actionAlert.addAction(galleryAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            actionAlert.addAction(cancelAction)
            
            actionAlert.popoverPresentationController?.sourceView = btnUpload // works for both iPhone & iPad

            present(actionAlert, animated: true) {
                print("option menu presented")
            }
            
          //  self.present(actionAlert, animated: true, completion: nil)
        }
        else
        {
            AlertView.shared.showAlert(message: Alert_HW_ImageUplaodImgLimitError, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
        }
        

        
    }
    
    func openCamera()
    {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openGallery()
    {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
      //  isImageFromGalley = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton)
    {
        CommonObject().showHUD()
        
        if strHWDate != "" && selectedSubID != 0 && selectedClassID != 0 && selectedSectionID != 0 && (txtViewWork.text != "" || arrHW_iamges.count > 0 )
        {
            let parmsDict = ["date":strHWDate, "subject":selectedSubID, "class":selectedClassID, "section":selectedSectionID,"content":txtViewWork.text ?? "","homework_link":arrHW_iamges] as [String : Any]
                
            let url = URL(string: postHomeWork)
            
            // generate boundary string using a unique per-app string
            let boundary = UUID().uuidString

            let session = URLSession.shared

            // Set the URLRequest to POST and to the specified URL
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"

            // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
            // And the boundary is also set here
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

         //   urlRequest.setValue("gzip, deflate", forHTTPHeaderField: "Accept-Encoding")

            var data = Data()
                        
               
            for (key, value) in parmsDict {

                // Add the reqtype field and its value to the raw http request data
                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                data.append("\(value)".data(using: .utf8)!)
                if value is [UIImage]
                {
                    for img in value as! [UIImage]
                    {
                        let image = img.jpegData(compressionQuality: 0.4)!
                        let imgName = Date().millisecondsSince1970
                        
                        // Add the image data to the raw http request data
                        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                        data.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(imgName).jpeg\"\r\n".data(using: .utf8)!)
                        data.append("Content-Type: \(mime_allTypes)\r\n\r\n".data(using: .utf8)!)
                        data.append(image)
                    }
                    
                }
                    
            }
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

            urlRequest.httpBody = data
            
            // Send a POST request to the URL, with the data we created earlier
            session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
                
                if(error != nil){
                    print("\(error!.localizedDescription)")
                    CommonObject().dismisHUD()
                }
                
                guard let responseData = responseData else {
                    print("no response data")
                    CommonObject().dismisHUD()
                    return
                }
                
                if let _ = String(data: responseData, encoding: .utf8) {
                    
                    DispatchQueue.main.async {
                        
                        AlertView.shared.showAlert(message: Alert_HomeWorkSuccess, toView: self, ButtonTitles: ["OK"], ButtonActions: [
                            { OKClicked in
                            
                                let _ = self.navigationController?.popViewController(animated: true)
                            
                            }])
                    }
                    
                    CommonObject().dismisHUD()
                }
            }).resume()
            
        }
        else
        {
            var strErrorMsg = ""
            
            if strHWDate == ""
            {
                strErrorMsg = Alert_EmptySlectedDate
            }
            else if selectedSubID == 0
            {
                strErrorMsg = Alert_EmptySlectedSubject
            }
            else if selectedClassID == 0
            {
                strErrorMsg = Alert_EmptySlectedClass
            }
            else if selectedSectionID == 0
            {
                strErrorMsg = Alert_EmptySlectedSection
            }
            else
            {
                strErrorMsg = Alert_Empty_HW_ContentOrImg
            }
            
            AlertView.shared.showAlert(message: strErrorMsg, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            CommonObject().dismisHUD()
        }
        
    }
    func getHomework()
    {
        CommonObject().showHUD()
        
        self.arrHomeWork.removeAll()
        
        if strHWDate != "" && selectedSubID != 0 && selectedClassID != 0 && selectedSectionID != 0
        {
            let parmsDict = ["date":strHWDate, "subject":selectedSubID, "class":selectedClassID, "section":selectedSectionID] as [String : Any]
            
            CommonObject().getDataFromServer(urlString: getHomeWorkByStudent, method: .POST, model: CommonResponceModel.self, paramsDict: parmsDict) { (data, resp, err) in
                
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

                                self.arrHomeWork = data?.details ?? []
                                self.updateView(details: self.arrHomeWork)

                            }
                            else
                            {
                                DispatchQueue.main.async {
                                    AlertView.shared.showAlert(message: Alert_NoHomeWork, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                                    self.txtViewWork.isHidden = true
                                    self.collnHWImages.isHidden = false
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
        else
        {
            var strErrorMsg = ""
            
            if strHWDate == ""
            {
                strErrorMsg = Alert_EmptySlectedDate
            }
            else if selectedSubID == 0
            {
                strErrorMsg = Alert_EmptySlectedSubject
            }
            else if selectedClassID == 0
            {
                strErrorMsg = Alert_EmptySlectedClass
            }
            else if selectedSectionID == 0
            {
                strErrorMsg = Alert_EmptySlectedSection
            }
            
            AlertView.shared.showAlert(message: strErrorMsg, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
            CommonObject().dismisHUD()
        }
    }
    
    
    func updateView(details:[CommonDetails])
    {
       // let homeWork = details[0]
        
         self.txtViewWork.text = ""
         self.arrHW_iamges.removeAll()
        
        for homeWork in details
        {
             var arrImgUrls = [String]()
            if homeWork.content?.count ?? 0 > 0
            {
                self.txtViewWork.text = self.txtViewWork.text + newLine + (homeWork.content ?? "")
            }
            
            self.txtViewWork.isHidden = false
            self.txtViewWork.isEditable  = false
            self.txtViewWork.isUserInteractionEnabled = true
            
            let fixedWidth = txtViewWork.frame.size.width
            let newSize = txtViewWork.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))

            if newSize.height < txtVwHConstraint.constant
            {
                txtVwHConstraint.constant = newSize.height
            }
            
            self.txtViewWork.scrollRangeToVisible(NSMakeRange(0, 0))
            
            let imgurls = homeWork.uploads?.components(separatedBy: "|||")
            
            if imgurls?.count ?? 0 > 0
            {
              arrImgUrls.append(contentsOf: imgurls!)
            }
            
            if arrImgUrls.count > 0
            {
                for imgUrl in arrImgUrls
                {
                    
                    let urlwithOutSpaces = imgUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

                    guard let url = URL(string: urlwithOutSpaces!) else { continue }
                    do
                    {
                        
                        let mimeType = url.mimeType()
                        
                       // print("mimeType is  ------ \(mimeType)")
                        arrHW_Urls.append(url)
                        
                        if mimeType == "image/png" || mimeType == "image/jpeg"
                        {
                            let data = try Data(contentsOf: url)
                            if data.count > 0 {
                                arrHW_iamges.append(UIImage(data:data)!)
                            }
                        }
                        else
                        {
                            arrHW_iamges.append(#imageLiteral(resourceName: "File"))
                        }
                        self.collnHWImages.reloadData()
                        self.collnHWImages.isHidden = false

                    }
                    catch let error
                    {
                        print(error)
                    }
                }
            }
        }
        
        if self.txtViewWork.text.count == 0
        {
             self.txtViewWork.isHidden = true
        }
    }

    func updateViewForDateSelection(enable:Bool)
    {
        if enable
        {
            self.stackSelectedDate.isHidden = false
            lblSelectedDay.isHidden = true
            lblSelectedDate.isHidden = false
            lblSelectedDate.textAlignment = .center
            self.buttonAppearance()
            txtViewWork.isUserInteractionEnabled = true
        }
        else
        {
            self.stackSelectedDate.isHidden = true
            btnSelectSubject.Disable()
            btnSelectClass.Disable()
            btnSelectSection.Disable()
            btnAdd.Disable()
            btnUpload.Disable()
            btnSubmit.Disable()
            txtViewWork.isUserInteractionEnabled = false
            
            AlertView.shared.showAlert(message: Alert_HW_PastDate, toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
        }
    }
    
    //MARK: - Homework Images Button Actions
    //Maerk: -
    // Zoom and Delete Actions
    
    @objc func HWImageZoom(sender:UIButton)
    {
        
        if arrHW_iamges[sender.tag] == #imageLiteral(resourceName: "File")
         {
             if arrHW_Urls[sender.tag].path.count > 0
             {
                 if UIApplication.shared.canOpenURL(arrHW_Urls[sender.tag])
                 {
                     UIApplication.shared.open(arrHW_Urls[sender.tag], options: [:], completionHandler: nil)
                 }
             }
         }
         else
         {
             let VC1 = MainSB.instantiateViewController(withIdentifier: "HW_ImagesOrVideosViewController") as! HW_ImagesOrVideosViewController
             let navController = UINavigationController(rootViewController: VC1)
             VC1.HWImg = arrHW_iamges[sender.tag]
             self.present(navController, animated:true, completion: nil)
         }
        
        
    }
    
    @objc func HWImageDelete(sender:UIButton)
    {
        if userDetails[0].roles == Role.Student_Parent.rawValue
        {
            AlertView.shared.showAlert(message:Alert_Save_HW_Image, toView: self, ButtonTitles: ["YES","NO"], ButtonActions: [{ yesClicked in
                
                let saveImg = self.arrHW_iamges[sender.tag]
                
                UIImageWriteToSavedPhotosAlbum(saveImg, nil, nil, nil)
                
                },nil])
            
        }
        else
        {
            AlertView.shared.showAlert(message:Alert_Delete_HW_Image, toView: self, ButtonTitles: ["YES","NO"], ButtonActions: [{ yesClicked in
                
                self.arrHW_iamges.remove(at: sender.tag)
                self.collnHWImages.reloadData()
                
                },nil])
        }

    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "segue_HW_imageZoom"
        {
            let destiVC = segue.destination as! HW_ImagesOrVideosViewController
            destiVC.HWImg = arrHW_iamges[sender as! Int]
            
        }
    }


}
extension HomeworkViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblSujects
        {
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                 return arrSubjects_Students.count
            }
            else
            {
                 return arrSubjects.count
            }
            
           
        }
        else if tableView == tblClassList
        {
            return arrClasses.count
        }
        else if tableView == tblSectionList
        {
            return arrSection.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       var CellIdentifier = ""
        
        if tableView == tblClassList
        {
           CellIdentifier =  "ClassCell"
        }
        else if tableView == tblSujects
        {
           CellIdentifier = "SubjectsCell"
        }
        else if tableView == tblSectionList
        {
            CellIdentifier = "SectionCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)!
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.textAlignment = .center
        
        if tableView == tblClassList
        {
            
            cell.textLabel?.text = (arrClasses[indexPath.row].name)
            if cell.textLabel?.text == strSelectedClass
            {
               // cell.accessoryType = .checkmark
                
                cell.textLabel?.backgroundColor = ColorsConfig.selctionBGColor
                cell.detailTextLabel?.text = "You Selected"
            }
            else
            {
                cell.textLabel?.backgroundColor = .clear
                cell.detailTextLabel?.text = ""
            }
        }
        else if tableView == tblSujects
        {
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                cell.textLabel?.text = arrSubjects_Students[indexPath.row].name
            }
            else
            {
                cell.textLabel?.text = arrSubjects[indexPath.row].name
            }
            
            if cell.textLabel?.text == strSelectedSub
            {
                cell.textLabel?.backgroundColor = ColorsConfig.selctionBGColor
                cell.detailTextLabel?.text = "You Selected"
            }
            else
            {
               // cell.accessoryType = .none
                cell.textLabel?.backgroundColor = .clear
                cell.detailTextLabel?.text = ""
            }
        }
        else if tableView == tblSectionList
        {
            cell.textLabel?.text = arrSection[indexPath.row].name
            if cell.textLabel?.text == strSelectedSection
            {
                cell.textLabel?.backgroundColor = ColorsConfig.selctionBGColor
                cell.detailTextLabel?.text = "You Selected"
            }
            else
            {
               // cell.accessoryType = .none
                cell.textLabel?.backgroundColor = .clear
                cell.detailTextLabel?.text = ""
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == tblClassList
        {
            self.btnSelectClass.setTitle(arrClasses[indexPath.row].name, for: .normal)
            
            self.strSelectedClass = arrClasses[indexPath.row].name!
            self.selectedClassID = arrClasses[indexPath.row].id!
            
            self.tblClassList.reloadData()
            
            UIView.animate(withDuration: 0.3) {
                
                self.tblClassList.isHidden = true
            }
            
          // stackSection.isHidden = false
        }
        else if tableView == tblSujects
        {
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                self.btnSelectSubject.setTitle(arrSubjects_Students[indexPath.row].name, for: .normal)
                
                self.strSelectedSub = arrSubjects_Students[indexPath.row].name!
                self.selectedSubID = arrSubjects_Students[indexPath.row].id!
            }
            else
            {
                self.btnSelectSubject.setTitle(arrSubjects[indexPath.row].name, for: .normal)
                
                self.strSelectedSub = arrSubjects[indexPath.row].name!
                self.selectedSubID = arrSubjects[indexPath.row].id!
            }
            

            self.tblSujects.reloadData()
            
            
            UIView.animate(withDuration: 0.3) {
                                
                self.tblSujects.isHidden = true
                
            }
        }
        else if tableView == tblSectionList
        {
            
            self.btnSelectSection.setTitle(arrSection[indexPath.row].name, for: .normal)
            
            self.strSelectedSection = arrSection[indexPath.row].name!
            self.selectedSectionID = arrSection[indexPath.row].id!
            
            self.tblSectionList.reloadData()
            
            UIView.animate(withDuration: 0.3) {
                
                self.tblSectionList.isHidden = true
            }
            
        }
        

    }
    
}
extension HomeworkViewController : FSCalendarDelegate
{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let selectedDate = CommonObject().getFormattedDate(date: date, format: "MMM d, yyyy - EEEE")
        
        strHWDate = CommonObject().getFormattedDate(date: date, format: DF_yyyy_MM_DD)
        
        let tdyDate = CommonObject().getFormattedDate(date: Date(), format: DF_yyyy_MM_DD)
        
        if strHWDate == tdyDate
        {
            self.updateViewForDateSelection(enable: true)
            lblSelectedDate.text = selectedDate
        }
        else
        {
            if userDetails[0].roles == Role.Student_Parent.rawValue
            {
                self.updateViewForDateSelection(enable: true)
                lblSelectedDate.text = selectedDate
            }
            else
            {
                let dateformat = DateFormatter()
                dateformat.dateFormat = DF_yyyy_MM_DD
                let selDate = dateformat.date(from: strHWDate) ?? Date()
                
                if selDate < Date()
                {
                    self.updateViewForDateSelection(enable: false)
                }
                else
                {
                    self.updateViewForDateSelection(enable: true)
                    lblSelectedDate.text = selectedDate
                }
            }
            
        }
    }
    
    
}

extension HomeworkViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrHW_iamges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HW_CollectionViewCell", for: indexPath) as! HW_CollectionViewCell
             
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 10
        
        cell.layer.borderColor = ColorsConfig.selctionBGColor.cgColor
        cell.layer.borderWidth = 1.5
            
        cell.img.image = arrHW_iamges[indexPath.row]
        cell.img.layer.cornerRadius = 10
        cell.img.clipsToBounds = true
        cell.img.contentMode = .scaleToFill
        
        cell.vwOptions.backgroundColor =  UIColor.black.withAlphaComponent(0.7)
        cell.vwOptions.layer.cornerRadius = 10
        cell.vwOptions.clipsToBounds = true
        
        cell.btnZoom.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        
        cell.btnZoom.addTarget(self, action: #selector(HWImageZoom(sender:)), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(HWImageDelete(sender:)), for: .touchUpInside)
       // cell.btnDelete.isHidden = true
        
        if userDetails[0].roles == Role.Student_Parent.rawValue
        {
            if cell.img.image == #imageLiteral(resourceName: "File")
            {
                cell.btnDelete.isHidden = true
            }
            else
            {
                cell.btnDelete.isHidden = false
                cell.btnDelete.setImage(#imageLiteral(resourceName: "save"), for: .normal)
            }
            
        }
        else
        {
            cell.btnDelete.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
        }
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if arrHW_iamges[indexPath.row] == #imageLiteral(resourceName: "File")
        {
            if arrHW_Urls[indexPath.row].path.count > 0
            {
                if UIApplication.shared.canOpenURL(arrHW_Urls[indexPath.row])
                {
                    UIApplication.shared.open(arrHW_Urls[indexPath.row], options: [:], completionHandler: nil)
                }
            }
        }
        else
        {
            let VC1 = MainSB.instantiateViewController(withIdentifier: "HW_ImagesOrVideosViewController") as! HW_ImagesOrVideosViewController
            let navController = UINavigationController(rootViewController: VC1)
            VC1.HWImg = arrHW_iamges[indexPath.row]
            self.present(navController, animated:true, completion: nil)
        }

        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = collnHWImages.frame.width / numberOfCellsPerRow
        
        let height = collectionView.frame.width / numberOfCellsPerRow
        
        return CGSize(width: width-10, height: height-20)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 100)
//    }
    
    
}
extension HomeworkViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate
{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let cameraImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        arrHW_iamges.append(cameraImage)
        picker.dismiss(animated: true, completion: nil)
        
        self.collnHWImages.isHidden = false
        self.collnHWImages.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    //    isImageFromGalley = false
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
}
