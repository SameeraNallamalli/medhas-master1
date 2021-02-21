//
//  WorksheetsUploadViewController.swift
//  Medha
//
//  Created by Ganesh on 05/02/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit
import MobileCoreServices

class WorksheetsUploadViewController: UIViewController {

    @IBOutlet weak var btnClass: UIButton!
    @IBOutlet weak var tblClass: UITableView!
    @IBOutlet weak var btnSection: UIButton!
    @IBOutlet weak var tblSection: UITableView!
    @IBOutlet weak var tblSubject: UITableView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnSubject: UIButton!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var fieldMarks: UITextField!
    @IBOutlet weak var btnSubmissionDate: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var lblUploadFileName: UILabel!
    
    
    var userDetails = [details]()
    var userData : LoginDetails!
    {
        didSet
        {
            userDetails = userData.details!
        }
         
    }
    
    var arrSubjects = [TeacherHandled]()
    var arrClassList = [TeacherHandled]()
    var arrSectionList = [TeacherHandled]()
    
    var strSelectedSub = ""
    var strSelectedClass = ""
    var strSelectedSection = ""
    var strSelectedTeacher = ""
    var strSubmissionDate = ""
    
    var idSelectedSub = 0
    var idSelectedClass = 0
    var idSelectedSection = 0
    
    var anyFile : Any?
    var selectedFileName = ""
    var arrSubClassHandled = [SubClassHandled]()
    
    @IBOutlet weak var classHConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sectionHConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var subjectHConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addGradientBGColor()
        self.btnClass.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        self.btnSection.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        self.btnSubject.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        self.btnSubmit.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        self.btnUpload.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
        self.btnSubmissionDate.addColors(titleColor: .white, bgColor: .clear, borderColor: .clear)
       
        self.tblClass.addAppearanceWith(isHide: true)
        self.tblSection.addAppearanceWith(isHide: true)
        self.tblSubject.addAppearanceWith(isHide: true)
        
        self.fieldMarks.addBorder()
        
        self.datePickerAppearance()
        
        arrSubClassHandled = userDetails[0].subj_class_handled!
        
        for subSecion in arrSubClassHandled
        {
            let subInfo = TeacherHandled(name: subSecion.subject_name, id: Int(subSecion.subject_id!))
            arrSubjects.append(subInfo)
            
            let classInfo = TeacherHandled(name: subSecion.class_name, id: Int(subSecion.class_id!))
            arrClassList.append(classInfo)
            
            let sectionInfo = TeacherHandled(name: subSecion.section_name, id: Int(subSecion.section_id!))
            arrSectionList.append(sectionInfo)
            
        }
        
        fieldMarks.attributedPlaceholder = NSAttributedString(string: "Enter Marks",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

        
        arrSubjects = arrSubjects.uniqueValues(value: {$0.id!})
        arrClassList = arrClassList.uniqueValues(value: {$0.id!})
        arrSectionList = arrSectionList.uniqueValues(value: {$0.id!})
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (self.tblClass.contentSize.height < classHConstraint.constant)
        {
             classHConstraint.constant = self.tblClass.contentSize.height
        }
        
        if (self.tblSection.contentSize.height < sectionHConstraint.constant)
        {
             sectionHConstraint.constant = self.tblSection.contentSize.height
        }
        
        if (self.tblSubject.contentSize.height < subjectHConstraint.constant)
        {
             subjectHConstraint.constant = self.tblSubject.contentSize.height
        }
        
    }
    
    func datePickerAppearance()
    {
        self.datePicker.isHidden = true
        self.datePicker.tintColor = .white
        self.datePicker.layer.borderColor = UIColor.white.cgColor
        self.datePicker.layer.borderWidth = 0.5
        self.datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        self.datePicker.setValue(false, forKey: "highlightsToday")
    }
    
    
    @IBAction func btnCancelClicked(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmissionDateClicked(_ sender: UIButton)
    {
        self.fieldMarks.resignFirstResponder()
        
        if !(tblSubject.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubject.isHidden = true
            }
        }
        
        if !(tblSection.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = true
            }
        }
        if !(tblClass.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = true
            }
        }
        
        
        if self.datePicker.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                 self.datePicker.isHidden = false
            }
        }
        else
        {
            
            UIView.animate(withDuration: 0.3) {
                
                 self.datePicker.isHidden = true
            }
        }
 
    }
    @IBAction func btnClassClicked(_ sender: UIButton)
    {
        if !(tblSubject.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubject.isHidden = true
            }
        }
        
        if !(tblSection.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = true
            }
        }
        
        if tblClass.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = true
            }
        }
        
        btnSubject.setTitle("Select Subject", for: .normal)
    }
    
    @IBAction func btnSectionClicked(_ sender: UIButton)
    {
        if !(tblSubject.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubject.isHidden = true
            }
        }
        
        if !(tblClass.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = true
            }
        }
        
        if tblSection.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = true
            }
        }
        
        btnSubject.setTitle("Select Subject", for: .normal)

    }
    @IBAction func btnSubjectClicked(_ sender: UIButton)
    {
        if !(tblClass.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = true
                
            }
        }
        
        if !(tblSection.isHidden)
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = true
                
            }
        }
        
        if tblSubject.isHidden
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubject.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubject.isHidden = true
            }
        }
    }
    
    @IBAction func datePickerSelected(_ sender: UIDatePicker)
    {
        strSubmissionDate = CommonObject().getFormattedDate(date: sender.date, format: DF_yyyy_MM_DD)
        
        self.btnSubmissionDate.setTitle(strSubmissionDate.toDate(Format: DF_dd_MM_yyyy), for: .normal)
        
    }
    
    @IBAction func btnUploadClicked(_ sender: UIButton)
    {
        
        let importMenu = UIDocumentPickerViewController(documentTypes: [String("public.data")], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        UINavigationBar.appearance().backgroundColor = .gray
        self.present(importMenu, animated: true, completion: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UINavigationBar.appearance().backgroundColor = .clear
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton)
    {
       // let img = #imageLiteral(resourceName: "ganesh")
        CommonObject().showHUD()
        
        let parmsDict = ["assign_ws_classes":idSelectedClass,"assign_ws_section":idSelectedSection,"assign_ws_subjects":idSelectedSub, "assign_ws_marks":fieldMarks.text!,"assign_ws_teacher":userDetails[0].id!,"assign_ws_date":strSubmissionDate,"worksheet_link":anyFile as! Data] as [String : Any]
        
            self.uploadImage(paramName: parmsDict)
        /*
        let headers: HTTPHeaders
        headers = ["Content-type": "multipart/form-data",
                   "Content-Disposition" : "form-data"]
        AF.upload(multipartFormData: { multiPart in
            for p in parmsDict {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            multiPart.append(img.jpegData(compressionQuality: 0.5)!, withName: "worksheet_link", fileName: "ganesh.jpeg", mimeType: "image/jpg")
        }, to: postWorksheet, method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
            print("upload finished: \(data)")
        }).response { (response) in
            switch response.result {
            case .success(let resut):
                print("upload success result: \(resut!)")
            case .failure(let err):
                print("upload err: \(err)")
            }
        }
        */
        
    }
      func uploadImage(paramName: [String: Any]) {
        
        
            let url = URL(string: postWorksheet)

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
                    
           
        for (key, value) in paramName {

            // Add the reqtype field and its value to the raw http request data
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            data.append("\(value)".data(using: .utf8)!)
            if value is Data
            {
                let image = value as! Data
                
                // Add the image data to the raw http request data
                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(selectedFileName)\"\r\n".data(using: .utf8)!)
                data.append("Content-Type: \(mime_allTypes)\r\n\r\n".data(using: .utf8)!)
                data.append(image)
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
                    
                    AlertView.shared.showAlert(message: Alert_WorksheetSuccess, toView: self, ButtonTitles: ["OK"], ButtonActions: [
                        { OKclicked in
                        
                            self.btnCancelClicked(self.btnCancel)
                        
                        },nil])
                }
                
                CommonObject().dismisHUD()
            }
        }).resume()
            
//            // Send a POST request to the URL, with the data we created earlier
//            session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
//                if error == nil {
//                    let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
//                    if let json = jsonData as? [String: Any] {
//                        print(json)
//                    }
//                }
//            }).resume()
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
extension WorksheetsUploadViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblSubject
        {
            return arrSubjects.count
        }
        else  if tableView == tblSection
        {
            return arrSectionList.count
        }
        else  if tableView == tblClass
        {
            return arrClassList.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblSubject
        {
            let cell = tblSubject.dequeueReusableCell(withIdentifier: "SubCell")

            cell?.textLabel?.text = arrSubjects[indexPath.row].name
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
            
            if cell?.textLabel?.text == strSelectedSub
            {
                cell?.accessoryType = .checkmark
                cell?.tintColor = .white
            }
            else
            {
                cell?.accessoryType = .none
            }
            
            return cell!
        }
        else if tableView == tblClass
        {
            let cell = tblClass.dequeueReusableCell(withIdentifier: "ClassCell")

            cell?.textLabel?.text = arrClassList[indexPath.row].name
            cell?.textLabel?.numberOfLines = 0
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
            cell?.textLabel?.textAlignment = .center
            
            if cell?.textLabel?.text == strSelectedClass
            {
                cell?.accessoryType = .checkmark
                cell?.tintColor = .white
            }
            else
            {
                cell?.accessoryType = .none
            }
            
            return cell!
        }
        else if tableView == tblSection
        {
            let cell = tblSection.dequeueReusableCell(withIdentifier: "SectionCell")

            cell?.textLabel?.text = arrSectionList[indexPath.row].name
            cell?.textLabel?.numberOfLines = 0
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
            cell?.textLabel?.textAlignment = .center
            
            if cell?.textLabel?.text == strSelectedSection
            {
                cell?.accessoryType = .checkmark
                cell?.tintColor = .white
            }
            else
            {
                cell?.accessoryType = .none
            }
            
            return cell!
        }
        else
        {
            let cell = tblSection.dequeueReusableCell(withIdentifier: "SectionCell")

            cell?.textLabel?.text = arrSectionList[indexPath.row].name
            cell?.textLabel?.numberOfLines = 0
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
            cell?.textLabel?.textAlignment = .center
            
            if cell?.textLabel?.text == strSelectedSection
            {
                cell?.accessoryType = .checkmark
                cell?.tintColor = .white
            }
            else
            {
                cell?.accessoryType = .none
            }
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == tblSubject
        {
            self.btnSubject.setTitle(arrSubjects[indexPath.row].name, for: .normal)
            
            self.strSelectedSub = arrSubjects[indexPath.row].name!
            self.idSelectedSub = arrSubjects[indexPath.row].id!
                                    
            UIView.animate(withDuration: 0.3) {
                
                self.tblSubject.isHidden = true
            }
            
            self.tblSubject.reloadData()
        }
        else if tableView == tblClass
        {
            self.btnClass.setTitle(arrClassList[indexPath.row].name, for: .normal)
            
            self.strSelectedClass = arrClassList[indexPath.row].name!
            self.idSelectedClass = arrClassList[indexPath.row].id!
                                    
            UIView.animate(withDuration: 0.3) {
                
                self.tblClass.isHidden = true
            }
            
            self.tblClass.reloadData()
        }
        else if tableView == tblSection
        {
            self.btnSection.setTitle(arrSectionList[indexPath.row].name, for: .normal)
            
            self.strSelectedSection = arrSectionList[indexPath.row].name!
            self.idSelectedSection = arrSectionList[indexPath.row].id!
            
            UIView.animate(withDuration: 0.3) {
                
                self.tblSection.isHidden = true
            }
            
            self.tblSection.reloadData()
        }
        else
        {
            
        }
        
    }
}
extension WorksheetsUploadViewController : UIDocumentPickerDelegate,UINavigationControllerDelegate
{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        selectedFileName = urls[0].lastPathComponent
        self.lblUploadFileName.text = selectedFileName
        
        do
        {
             anyFile = try Data(contentsOf: urls.first!, options: [])
        }
        catch let err
        {
            print(err)
        }
 
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
        controller.dismiss(animated: true, completion: nil)
    }
    
}
