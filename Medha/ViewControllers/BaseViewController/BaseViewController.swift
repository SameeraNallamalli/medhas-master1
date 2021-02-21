//
//  BaseViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 25/11/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

     //   viewNavBar.backgroundColor = .yellow
        
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

/*
extension BaseViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
              
        if section == 0
        {
            return 20
        }
        else
        {
            return 2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        if indexPath.section == 0
        {
            cell.backgroundColor = .red
            
        }
        else
        {
            cell.backgroundColor = .green
        }
        
      //  cell.backgroundColor = indexPath.row % 2 == 0 ? .red : .yellow
        
       return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {


        
        return CGSize(width: 100, height: 100)
        
        
       
    }


}
*/
