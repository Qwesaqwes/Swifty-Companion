//
//  ProfileViewController.swift
//  Swifty Companion
//
//  Created by Jimmy CHEN-MA on 10/16/18.
//  Copyright © 2018 Jimmy CHEN-MA. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController
{
    var profile:Profile?
    
    @IBOutlet weak var loginText: UILabel!
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var locationText: UILabel!
    @IBOutlet weak var walletText: UILabel!
    @IBOutlet weak var cpText: UILabel!
    @IBOutlet weak var fullNameText: UILabel!
    @IBOutlet weak var levelText: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var topView: UIView!
    
    
    /*--------------------------------------*/
    /*---------------FUNCTION---------------*/
    /*--------------------------------------*/
    
    func displayTopView()
    {
        topView.backgroundColor = UIColor.gray
        
        loginText.text = profile?.login
        emailText.text = profile?.email
        if let loc = profile?.location
        {
            locationText.text = loc
        }
        else
        {
            locationText.text = "Unavailable"
        }
        walletText.text = String(describing: "Wallet: " + String(describing: (profile?.wallet)!))
        cpText.text = String(describing: "Correction: " + String(describing : (profile?.correction_point)!))
        fullNameText.text = String(describing: (profile?.first_name)! + " " + (profile?.last_name)!)
        levelText.text = String(describing: "Level: " + String(Float((profile?.cursus_users.first?.level)!)))
        progressBar.progress = Float((profile?.cursus_users.first?.level)!) - Float(Int((profile?.cursus_users.first?.level)!))
        
        let url = URL(string: (profile?.image_url)!)
        DispatchQueue.global(qos:DispatchQoS.background.qosClass).async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                let res = UIImage(data: data!)
                if (res == nil)
                {
                    let alert = UIAlertController(title: "Error", message: "Failed to load image.", preferredStyle:UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                self.userImage.image = res
            }
        }
    }
    
    /*--------------------------------------*/
    /*---------------OVERRIDE---------------*/
    /*--------------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        displayTopView()
        
        
        
//        print (profile as Any)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
