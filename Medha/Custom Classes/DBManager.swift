//
//  DBManager.swift
//  Medha
//
//  Created by Ganesh Musini on 27/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import CoreData
import UIKit

class DBManager
{
    static let shared : DBManager = DBManager()
    
    func fetch(entity:NSManagedObject.Type,showAlertForErrorIn:UIViewController) -> [NSManagedObject]
    {
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: entity.description())
     
        do
        {
            if let results = try context.fetch(fetchReq) as? [NSManagedObject]
            {
                return results
            }
            
        }catch let error{
            
            AlertView.shared.showAlert(message: "Fetching error \(error.localizedDescription)", toView: showAlertForErrorIn, ButtonTitles: ["OK"], ButtonActions: [nil])
        }
        
        return []
    }

    func Delete(entity:NSManagedObject.Type,showAlertForErrorIn:UIViewController,completion:@escaping(_ status:Bool)->())
    {
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: entity.description())
        do
        {
            if let results = try context.fetch(fetchReq) as? [NSManagedObject]
            {
                for result in results
                {
                    context.delete(result)
                }
                do
                {
                   try context.save()
                       completion(true)
                }
                catch let err {
                    print(err.localizedDescription)
                       completion(false)
                }
            }
            
        }catch let error{
            
            AlertView.shared.showAlert(message: "Fetching error \(error.localizedDescription)", toView: showAlertForErrorIn, ButtonTitles: ["OK"], ButtonActions: [nil])
            
            completion(false)
        }
        
    }
    
}
