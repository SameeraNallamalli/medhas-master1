//
//  HW_ImagesOrVideosViewController.swift
//  Medha
//
//  Created by Ganesh Musini on 15/12/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//

import UIKit

class HW_ImagesOrVideosViewController: UIViewController {
        
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var HwImage: UIImageView!
    @IBOutlet weak var scrollVC: UIScrollView!
    
    var HWImg = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addGradientBGColor()
        self.HwImage.image = HWImg
        
        scrollVC.minimumZoomScale = 1.0
        scrollVC.maximumZoomScale = 20.0
        
    }
    
    @IBAction func btnCancelClicked(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil)
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
extension HW_ImagesOrVideosViewController : UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return HwImage
    }
    
    
}
