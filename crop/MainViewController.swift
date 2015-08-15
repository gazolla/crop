//
//  MainViewController.swift
//  crop
//
//  Created by Gazolla on 15/08/15.
//  Copyright (c) 2015 Gazolla. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    lazy var imgView:UIImageView = {
        var i = UIImageView(frame: CGRectMake(0, 120, self.view.bounds.width, 200))
        i.image = UIImage(named: "forest")
        i.contentMode = UIViewContentMode.ScaleAspectFill

        return i
        }()

    lazy var cropButton : UIButton = {
        var c: UIButton = UIButton(frame: CGRectMake(10, self.view.bounds.height - 50, 150, 30))
        c.setTitle("Crop with Navigator", forState: UIControlState.Normal)
        c.titleLabel?.font =  UIFont(name: "Arial", size: 14)
        c.addTarget(self, action: "cropAction", forControlEvents: UIControlEvents.TouchUpInside)
        c.backgroundColor = UIColor.blueColor()
        return c
        
        }()
    
    lazy var crop2Button : UIButton = {
        var c: UIButton = UIButton(frame: CGRectMake(180, self.view.bounds.height - 50, 150, 30))
        c.setTitle("Crop without Navigator", forState: UIControlState.Normal)
        c.titleLabel?.font =  UIFont(name: "Arial", size: 14)
        c.addTarget(self, action: "crop2Action", forControlEvents: UIControlEvents.TouchUpInside)
        c.backgroundColor = UIColor.blueColor()
        return c
        
        }()
    
    func cropAction(){
        UIGraphicsBeginImageContext(UIApplication.sharedApplication().keyWindow!.bounds.size)
        UIApplication.sharedApplication().keyWindow!.layer.renderInContext(UIGraphicsGetCurrentContext())
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        let crop = CGRectMake(0, 0,
            self.view.bounds.width,
            self.view.bounds.height )
        
        let cgImage = CGImageCreateWithImageInRect(screenshot.CGImage, crop)
        let image: UIImage = UIImage(CGImage: cgImage)!
        
        
        
        var path = self.applicationDocumentsDirectory().path!
        path = path + "/" + "imgBar.png"
        UIImagePNGRepresentation(image).writeToFile(path, atomically: true)
     }
    
    func crop2Action(){
        UIGraphicsBeginImageContext(UIApplication.sharedApplication().keyWindow!.bounds.size)
        UIApplication.sharedApplication().keyWindow!.layer.renderInContext(UIGraphicsGetCurrentContext())
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let yPosition = self.navigationController!.navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.size.height

        let crop = CGRectMake(0, yPosition,
            self.view.bounds.width,
            self.view.bounds.height )
        
        let cgImage = CGImageCreateWithImageInRect(screenshot.CGImage, crop)
        let image: UIImage = UIImage(CGImage: cgImage)!
        
        
        
        var path = self.applicationDocumentsDirectory().path!
        path = path + "/" + "img.png"
        UIImagePNGRepresentation(image).writeToFile(path, atomically: true)
    }
    
    func applicationDocumentsDirectory() -> NSURL {
        var documentsDirectory:String?
        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true);
        if paths.count > 0 {
            if let pathString = paths[0] as? NSString {
                documentsDirectory = pathString as String
            }
        }
        
        return NSURL(string: documentsDirectory!)!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "Crop Test"
        self.view.addSubview(self.imgView)
        self.view.addSubview(self.cropButton)
        self.view.addSubview(self.crop2Button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
