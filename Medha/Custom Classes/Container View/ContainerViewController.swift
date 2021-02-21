//
//  ContainerViewController.swift
//
//
//  Created by Aaqib Hussain on 03/08/2015.
//  Copyright (c) 2015 Kode Snippets. All rights reserved.
//

import UIKit
import CoreData

open class ContainerViewController: UIViewController {
    //Manipulating container views
    fileprivate weak var viewController : UIViewController!
    //Keeping track of containerViews
    fileprivate var containerViewObjects = Dictionary<String,UIViewController>()
    /** Pass in a tuple of required TimeInterval with UIViewAnimationOptions */
    var animationDurationWithOptions:(TimeInterval, UIView.AnimationOptions) = (0,[])
    
    @IBOutlet var swipeGestureRight: UISwipeGestureRecognizer!
    @IBOutlet var swipeGestureLeft: UISwipeGestureRecognizer!
    
    /** Specifies which ever container view is on the front */
    open var currentViewController : UIViewController{
        get {
            return self.viewController
            
        }
    }
    /** Returns all the embedded controllers **/
    open var viewControllers: [UIViewController] {
        return Array(containerViewObjects.values)
    }
    
    fileprivate var segueIdentifier : String!
    
    /*Identifier For First Container SubView*/
    @IBInspectable internal var firstLinkedSubView : String!
    
    var userData : LoginDetails!
    var arrDropDownList : DefaultLists!
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.fetchProfileData()
       // self.fetchDropDownLists()
        self.getDropDownLists()
        

    }
    open override func viewDidAppear(_ animated: Bool) {

    }
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDropDownLists()
    {
        CommonObject().showHUD()
        
        CommonObject().getDataFromServer(urlString: getDefaultLists, method: .GET, model: DefaultLists.self, paramsDict: [:]) { (data, resp, err) in
            
            if err == nil && resp != nil
            {
                
                DispatchQueue.main.async {
                    
                    self.saveDropDownData(userModel: data!)
                    
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
                            
                            if let identifier = self.firstLinkedSubView{
                                self.segueIdentifierReceivedFromParent(identifier, segue: .fromRight)
                            }
                        }
                    }
                    else
                    {
                        DispatchQueue.main.async {
                            let statusCode = resp as! HTTPURLResponse
                            AlertView.shared.showAlert(message: "Erro in network\nStatus Code :\(statusCode.statusCode)", toView: self, ButtonTitles: ["OK"], ButtonActions: [nil])
                            
                            if let identifier = self.firstLinkedSubView{
                                self.segueIdentifierReceivedFromParent(identifier, segue: .fromRight)
                            }
                        }
                    }
                     CommonObject().dismisHUD()
                }
            }
            
        }
    }
    
    func saveDropDownData(userModel:DefaultLists)
    {
        let request : NSFetchRequest<DropDownLists>
        request = DropDownLists.fetchRequest()
        do
        {
            let results = try context.fetch(request)
            
            if results.count > 0
            {
                for item in results {
                    
                    context.delete(item)
                }

           }
           
        }
        catch let err
        {
           print(err.localizedDescription)
        }

        let entity = NSEntityDescription.entity(forEntityName: "DropDownLists", in: context)
        let dropDown = NSManagedObject(entity: entity!, insertInto: context) as! DropDownLists
        
        dropDown.model = userModel
        
         print("Storing dropDown Data..")
        do
        {
            try context.save()
           
            self.fetchDropDownLists()
            
            CommonObject().dismisHUD()
            
         } catch {
             print("Storing data Failed")
            CommonObject().dismisHUD()
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
    
    func fetchDropDownLists()
    {
        let dropdownData = DBManager.shared.fetch(entity: DropDownLists.self, showAlertForErrorIn: self) as? [DropDownLists]
        
        if dropdownData!.count > 0
        {
            print("Fetch dropdeon data")
            let lists = dropdownData![0].model as! DefaultLists
            arrDropDownList = lists
            
            if let identifier = firstLinkedSubView{
                segueIdentifierReceivedFromParent(identifier, segue: .fromRight)
            }
        }

    }
    
    func segueIdentifierReceivedFromParent(_ identifier: String,segue:CATransitionSubtype){
        
        self.segueIdentifier = identifier
        self.performSegue(withIdentifier: self.segueIdentifier, sender: segue)
        
    }
    
    @IBAction func respondToSwipeGesture(_ sender: UISwipeGestureRecognizer)
    {
            switch sender.direction {
            case .right:
                NotificationCenter.default.post(name: .swipedRight, object: self)
            case .left:
                NotificationCenter.default.post(name: .swipedLeft, object: self)
                default:
                    break
            }        
    }
        
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier{
            //Remove Container View
            if viewController != nil{
                viewController.view.removeFromSuperview()
                viewController = nil
                
            }
            //Add to dictionary if isn't already there
            if ((self.containerViewObjects[self.segueIdentifier] == nil)){
                viewController = segue.destination
                self.containerViewObjects[self.segueIdentifier] = viewController
                
                if viewController.isKind(of: MenuPage1ViewController.self)
                {
                    let menu1VC = viewController as! MenuPage1ViewController
                    menu1VC.userData = userData
                    menu1VC.dropDownLists = arrDropDownList
                }
                else if viewController.isKind(of: MenuPage2ViewController.self)
                {
                    let menu2VC = viewController as! MenuPage2ViewController
                    menu2VC.userData = userData
                    menu2VC.dropDownLists = arrDropDownList
                }
                
            }else{
                for (key, value) in self.containerViewObjects{
                    
                    if key == self.segueIdentifier{
                        viewController = value
                    }
                }
                
            }
            
            var caTransitionSubtype : CATransitionSubtype = .fromRight
            
            if sender != nil
            {
                caTransitionSubtype = sender as! CATransitionSubtype

            }
            
                
            self.addChild(self.viewController)
            self.viewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
            
             let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
            transition.type = CATransitionType.push
            transition.subtype = caTransitionSubtype
            self.view.addSubview(self.viewController.view)
            self.view.layer.add(transition, forKey: nil)
            self.viewController.didMove(toParent: self)
                

            
            
//            UIView.transition(with: self.view, duration: animationDurationWithOptions.0, options: animationDurationWithOptions.1, animations: {
//                self.addChild(self.viewController)
//                self.viewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
//                self.view.addSubview(self.viewController.view)
//            }, completion: { (complete) in
//                self.viewController.didMove(toParent: self)
//            })
           
           
            
        }
        
    }
    
    
}
