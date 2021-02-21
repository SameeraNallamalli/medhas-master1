//
//  SchoolImgesViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 06/01/20.
//  Copyright © 2020 Ganesh Musini. All rights reserved.
//

import UIKit

class SchoolImgesViewController: UIViewController {
    
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var imgCollnView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var strTitle = ""
    let arrImages = [UIImage(named: "iu-1"),UIImage(named: "iu-2"),UIImage(named: "iu-3"),UIImage(named: "iu-4"),UIImage(named: "iu-5"),UIImage(named: "iu-6"),UIImage(named: "iu-7"),UIImage(named: "iu-8"),UIImage(named: "iu-9"),UIImage(named: "iu-10")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addGradientBGColor()
        self.title = strTitle
        imgCollnView.backgroundColor = .clear
        imgCollnView.layer.cornerRadius = 10
        imgCollnView.clipsToBounds = true
        
        lblHeading.isHidden = true
        self.pageControlConfiguration()
        
    }
    
    func pageControlConfiguration()
    {
        self.pageControl.numberOfPages = arrImages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = .white
        self.pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.4)
        self.pageControl.currentPageIndicatorTintColor = .white
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let currentIndex = self.imgCollnView.contentOffset.x / self.imgCollnView.frame.size.width;

        self.pageControl.currentPage = Int(currentIndex)
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
extension SchoolImgesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SchoolImagesCollectionViewCell", for: indexPath) as! SchoolImagesCollectionViewCell
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 10
        cell.img.image = arrImages[indexPath.row]
       return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size;
    }

}
