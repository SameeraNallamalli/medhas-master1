//
//  CommonObject.swift
//  Medha
//
//  Created by Ganesh Musini on 11/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import Foundation
import UIKit
//import IHProgressHUD
import PKHUD

enum WShttpMethod : String {
    case GET
    case POST
}

enum Role : Int {
    case Admin = 1
    case Principal = 2
    case Teacher = 3
    case Student_Parent = 4
}


class CommonObject : NSObject
{

    func getWSNameFrom(urlStr: String) -> String
    {
        var nameStr = ""
        if urlStr.contains("http")
        {
            nameStr = urlStr.components(separatedBy: "/").last!
        }
        
        return nameStr
    }
    
    func getDataFromServer<T>(urlString:String,method:WShttpMethod? ,model:T.Type, paramsDict:[String:Any]?, completion:@escaping (T?, URLResponse?, String?) -> ()) where T: Decodable
    {
        guard let urlReq = URL(string: urlString) else { return }
     
        print("Params Dict for ----- \(self.getWSNameFrom(urlStr: urlString)) ------ \(paramsDict ?? [:])")
        
        var request = URLRequest(url: urlReq)
        request.httpMethod = method?.rawValue
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        if method != WShttpMethod.GET
        {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: paramsDict ?? [], options: []) else {
                return
            }
            request.httpBody = httpBody
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            
            if err != nil || data == nil
            {
                print("Client Error \(err?.localizedDescription ?? "error")")
                let errorStr = err?.localizedDescription
                
                completion(nil, nil, errorStr)
                
                return
            }
            
            guard let resp = response as? HTTPURLResponse, resp.isResponseOK() else {
               // let respCode = response as? HTTPURLResponse
                
                completion(nil,response,"Not a success response code")
                return
            }
            
            
            guard let data = data else {return}
                        
            let _ = data.printJSON(name:self.getWSNameFrom(urlStr: urlString))
           
            
            do
            {
                let dataJson = try JSONDecoder().decode(model, from: data)
                completion(dataJson, response, nil)
                
            }
            catch let jsonErr
            {
                completion(nil, nil, jsonErr.localizedDescription)
            }
            
        }.resume()
    }
    
    
    func showAlert(message:String, toView:UIViewController)
    {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(alertAction)
        
        toView.present(alert, animated: true, completion: nil)
    }
    
    
    func showHUD()
    {
       // IHProgressHUD.show()
     //   IHProgressHUD.set(defaultMaskType: .black)
        
        HUD.show(.progress)
    }
    
    func dismisHUD()
    {
       // IHProgressHUD.dismiss()
        DispatchQueue.main.async {
            HUD.hide()
        }
        
       // HUD.hide()
    }
    
    func getAverage(total:Int,secured:Int) -> Int {
        
        let present = Float(secured)
        let total = Float(total)
        let average = present/total
        let monthlyPercentage = Int(average * 100)
       
        return monthlyPercentage        
    }
    
    func getFormattedDate(date: Date, format: String) -> String {
            let dateformat = DateFormatter()
            dateformat.dateFormat = format
            return dateformat.string(from: date)
    }
    /*
    func shimmerLabel()
          {
              let darkLabel = UILabel()
              darkLabel.text = "To get started, click on the \n'+ Material' button"
              darkLabel.textColor = UIColor(white: 1, alpha: 0.15)
              darkLabel.font = UIFont.systemFont(ofSize: 25)
              darkLabel.textAlignment = .center
              darkLabel.numberOfLines = 0
              darkLabel.frame = CGRect(x: 0, y: 0, width: vwCustomFields.frame.width, height: vwCustomFields.frame.height)
       
              self.vwCustomFields.addSubview(darkLabel)
              
              let whiteLabel = UILabel()
              whiteLabel.text = "To get started, click on the \n'+ Material' button"
              whiteLabel.textColor = .white
              whiteLabel.font = UIFont.systemFont(ofSize: 25)
              whiteLabel.numberOfLines = 0
              whiteLabel.textAlignment = .center
              whiteLabel.frame = CGRect(x: 0, y: 0, width: vwCustomFields.frame.width, height: vwCustomFields.frame.height)

              self.vwCustomFields.addSubview(whiteLabel)
              
              let gradientLayer = CAGradientLayer()
              gradientLayer.colors = [UIColor.clear.cgColor,UIColor.white.cgColor,UIColor.clear.cgColor]
              gradientLayer.locations = [0,0.5,1]
              gradientLayer.frame = whiteLabel.frame
              
              let angle = 45 * CGFloat.pi / 100
              gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
              
              whiteLabel.layer.mask = gradientLayer
              
              //Animation
              let animation = CABasicAnimation(keyPath: "transform.translation.x")
              animation.duration = 1.5
              animation.fromValue = -self.vwCustomFields.frame.width
              animation.toValue = self.vwCustomFields.frame.height
              animation.repeatCount = Float.infinity
              gradientLayer.add(animation, forKey: "no material label")
          }
 */
}



