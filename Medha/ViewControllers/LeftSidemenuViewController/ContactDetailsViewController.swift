//
//  ContactDetailsViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 05/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit
import WebKit

class ContactDetailsViewController: UIViewController,WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var strTitle = ""
    var webVC : WKWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.addGradientBGColor()
        self.title = strTitle
        
        webVC = WKWebView()
        
        self.contentView.addSubview(webVC)
        
        webVC.navigationDelegate = self
        webVC.configuration.dataDetectorTypes = [.link, .phoneNumber]
        webVC.uiDelegate = self
        webVC.scrollView.delegate = self
        
        webVC.translatesAutoresizingMaskIntoConstraints = false
        webVC.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        webVC.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        webVC.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        webVC.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        let url = URL(string: "http://medhasedutech.com/contactUs.html")!
        webVC.load(URLRequest(url: url))
        webVC.allowsBackForwardNavigationGestures = true
        webVC.allowsLinkPreview = true
        self.webVC.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: [.new,.old], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "loading"
        {
            if webVC.isLoading
            {
                self.indicator.startAnimating()
                self.indicator.isHidden = false
            }
            else
            {
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
            
        }
        else
        {
            self.indicator.stopAnimating()
            
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url?.absoluteString
         let urlElements = url?.components(separatedBy: ":") ?? []

         switch urlElements[0] {

         case "tel":
            UIApplication.shared.open(navigationAction.request.url!, options:  [:], completionHandler: nil)
             decisionHandler(.cancel)
         case "mailto":
            UIApplication.shared.open(navigationAction.request.url!, options:  [:], completionHandler: nil)
             decisionHandler(.cancel)
         default:
             decisionHandler(.allow)
         }
    }
    // Disable zooming in webView
       func viewForZooming(in: UIScrollView) -> UIView? {
           return nil
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
