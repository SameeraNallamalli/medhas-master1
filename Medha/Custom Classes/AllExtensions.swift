//
//  AllExtensions.swift
//  Medha
//
//  Created by Ganesh Musini on 30/11/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

enum viewBorder: String {
    case Left = "borderLeft"
    case Right = "borderRight"
    case Top = "borderTop"
    case Bottom = "borderBottom"
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

extension Int {
    var romanNumeral: String {
        var integerValue = self
        var numeralString = ""
        let mappingList: [(Int, String)] = [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"), (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]
        for i in mappingList {
            while (integerValue >= i.0) {
                integerValue -= i.0
                numeralString += i.1
            }
        }
        return numeralString
    }
    
    func correspondingLetter(inUppercase uppercase: Bool = false) -> String? {
        let firstLetter = uppercase ? "A" : "a"
        let startingValue = Int(UnicodeScalar(firstLetter)!.value)
        if let scalar = UnicodeScalar(self + startingValue) {
            return String(scalar)
        }
        return nil
    }
}

extension UITableView
{
    func addAppearanceWith(isHide:Bool,borderColor:UIColor?=nil)
    {
        self.isHidden = isHide
        if borderColor != nil
        {
            self.layer.borderColor = borderColor?.cgColor
            self.layer.borderWidth = 0.5
        }
        self.separatorColor = ColorsConfig.tblSeparatorColor
        self.tableFooterView = UIView()
        self.tintColor = .white
        self.backgroundColor = .clear
        
    }
    
}

extension UIView {

    func addBorder(vBorders: [viewBorder], color: UIColor, width: CGFloat) {
        vBorders.forEach { vBorder in
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.name = vBorder.rawValue
            switch vBorder {
            case .Left:
                border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
            case .Right:
                border.frame = CGRect(x:self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
            case .Top:
                border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
            case .Bottom:
                border.frame = CGRect(x: 0, y: self.frame.size.height - width , width: self.frame.size.width, height: width)
            }
            self.layer.addSublayer(border)
        }
    }
    
    
}
extension UITextView
{
    func addBorder()
    {
        self.backgroundColor = ColorsConfig.BGColor_Grey
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.5
        self.tintColor = .white
        self.textColor = .white
        self.addDoneButtonOnKeyboard()
    }
    
   private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
    }
    
    @objc private func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}

extension UITextField
{
    func addBorder()
    {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.5
        self.tintColor = .white
        self.textColor = .white
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.4)])
        self.addDoneButtonOnKeyboard()
    }
    
    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
    }
    
    @objc private func doneButtonAction()
    {
        self.resignFirstResponder()
    }
    
    
}

extension String {
    var isValidEmail: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    var isValidPhoneNumber: Bool {
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
    
    func toDate(Format:String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DF_yyyy_MM_DD
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = Format
        return  dateFormatter.string(from: date)
        
    }
}
extension Array
{
   func uniqueValues<V:Equatable>( value:(Element)->V) -> [Element]
   {
      var result:[Element] = []
      for element in self
      {
        if !result.contains(where: { value($0) == value(element) })
         { result.append(element) }
      }
      return result
   }
}

extension Data
{
    func printJSON(name:String)
    {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8)
        {
            print("\(name) JSON ---- \(JSONString)")
        }
    }
}

extension Date {
 var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
        //RESOLVED CRASH HERE
    }

    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}
extension UIButton
{
    func addColors(titleColor:UIColor,bgColor:UIColor?,borderColor:UIColor?)
    {
        if bgColor != nil
        {
            self.backgroundColor = ColorsConfig.BGColor_Grey
        }
        else
        {
            self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        }
        if borderColor != nil
        {
            //self.layer.borderColor = borderColor?.cgColor
            self.layer.borderColor = UIColor.white.cgColor
        }
        else
        {
           self.layer.borderColor = UIColor.white.cgColor
        }
        
        self.layer.borderWidth = 1.5
        self.setTitleColor(titleColor, for: .normal)
        self.isUserInteractionEnabled  = true
       // let btnImage = #imageLiteral(resourceName: "but")
       // let btnImage1 = #imageLiteral(resourceName: "BG_button")
        
       // self.setBackgroundImage(btnImage, for: .normal)
    }
    
    func Disable()
    {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.5
        self.setTitleColor(.lightGray, for: .normal)
        self.isUserInteractionEnabled = false
    }
    
    func leftImage(image: UIImage, renderMode: UIImage.RenderingMode) {
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: image.size.width / 2)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
    }

    func rightImage(image: UIImage, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left:image.size.width / 2, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .right
        self.imageView?.contentMode = .scaleAspectFit
    }

}

extension UISearchBar {
    var textField : UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            // Fallback on earlier versions
            for view : UIView in (self.subviews[0]).subviews {
                if let textField = view as? UITextField {
                    return textField
                }
            }
        }
        return nil
    }
}
extension UIStackView {

    func addBackground(withBGColor:UIColor,borderColor:UIColor) {
        let subview = UIView(frame: bounds)
        subview.backgroundColor = withBGColor
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subview.layer.borderColor = borderColor.cgColor
        subview.layer.borderWidth = 1
        subview.layer.cornerRadius = 10
        insertSubview(subview, at: 0)
    }

    func addBorderWith(borders:[viewBorder],BGColor:UIColor,borderColor:UIColor,cornerRadius:Bool? = nil) {
        let subview = UIView(frame: bounds)
        subview.backgroundColor = BGColor
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //subview.layer.borderColor = borderColor.cgColor
       // subview.layer.borderWidth = 1
        subview.addBorder(vBorders: borders, color: borderColor, width: 1)
        if cornerRadius == true
        {
            subview.layer.cornerRadius = 5
            subview.clipsToBounds = true
        }
        
        insertSubview(subview, at: 0)
    }
    
}
extension UILabel
{
    func attendaceLblAppearance(bgColor:UIColor)
    {
        self.backgroundColor = bgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        self.textColor = .white
        
    }
    
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font as Any], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
 
}
extension HTTPURLResponse {
     func isResponseOK() -> Bool {
        print("Status Code : \(self.statusCode)")
      return (200...299).contains(self.statusCode)
     }
    func getStatusCode() -> Int {
        return self.statusCode
    }
    
}

extension URL {
    func mimeType() -> String {
        let pathExtension = self.pathExtension
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    var containsImage: Bool {
        let mimeType = self.mimeType()
        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
            return false
        }
        return UTTypeConformsTo(uti, kUTTypeImage)
    }
    var containsAudio: Bool {
        let mimeType = self.mimeType()
        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
            return false
        }
        return UTTypeConformsTo(uti, kUTTypeAudio)
    }
    var containsVideo: Bool {
        let mimeType = self.mimeType()
        guard  let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
            return false
        }
        return UTTypeConformsTo(uti, kUTTypeMovie)
    }

//Get current mime type of url w.r.t its url
    var currentMimeType: String {

        if self.containsImage{
            return "image/png"
        }else if self.containsAudio{
            return "audio/mp3"
        }else if self.containsVideo{
            return "video/mp4"
        }

        return ""
    }
}
extension UIViewController
{
    
    func addGradientBGColor()
    {
//        self.view.backgroundColor = .white
//        let gradientColos = CAGradientLayer()
//        let color1 = UIColor(red: 233/255.0, green: 170/255.0, blue: 128/255.0, alpha: 1)
//        let color2 = UIColor(red: 60/255.0, green: 56/255.0, blue: 95/255.0, alpha: 1)
//      //  let color3 = UIColor(red: 0/255.0, green: 66/255.0, blue: 116/255.0, alpha: 1)
//
//        gradientColos.colors = [color1.cgColor,color2.cgColor]
//        gradientColos.locations = [0.3,1.0]
//        gradientColos.frame = self.view.bounds
//        self.view.layer.insertSublayer(gradientColos, at: 0)
        
        
        let imageView = UIImageView()
        imageView.frame = self.view.bounds
        imageView.image = #imageLiteral(resourceName: "BG")
        imageView.contentMode = .scaleToFill
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
       // self.view.backgroundColor = UIColor.init(red: 1/255.0, green: 31/255.0, blue: 75/255.0, alpha: 1)
        
    }

}
let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .gray)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center

        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
                
            }

        }).resume()
    }
}

extension UINavigationController
{
    func addCustomBottomLine(color:UIColor,height:Double)
    {
        //Hiding Default Line and Shadow
        navigationBar.setValue(true, forKey: "hidesShadow")

        //Creating New line
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width:0, height: height))
        lineView.backgroundColor = color
        navigationBar.addSubview(lineView)

        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalTo: navigationBar.widthAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        lineView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
    }
}

extension Notification.Name
{
    static let swipedRight = Notification.Name("swipedRight")
    static let swipedLeft = Notification.Name("swipedLeft")
}
