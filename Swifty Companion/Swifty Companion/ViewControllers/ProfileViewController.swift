//
//  ProfileViewController.swift
//  Swifty Companion
//
//  Created by Jimmy CHEN-MA on 10/16/18.
//  Copyright © 2018 Jimmy CHEN-MA. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    var profile:Profile?
    var api42Controller:Api42Controller?
    
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
    @IBOutlet weak var skillTableView: UITableView!
    
    var tmpArray:[Project] = []
    var backgroundId:Int = 0
    
    /*--------------------------------------*/
    /*---------------FUNCTION---------------*/
    /*--------------------------------------*/
    
    func displayTopView()
    {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == skillTableView
        {
            return (profile?.cursus_users.first!.skills.count)!
        }
        else if !(tmpArray.isEmpty)
        {
            var i:Int = 0
            for a in tmpArray
            {
                if a.project.name.contains("Day") || a.cursus_ids.first == 4
                {
                    tmpArray.remove(at: i)
                }
                else
                {
                    i += 1
                }
            }
        }
        return tmpArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == skillTableView
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell") as! SkillTableViewCell
            cell.displaySkill(skill: (profile?.cursus_users.first!.skills[indexPath.row])!)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell") as! ProjectTableViewCell
        cell.displayProject(project: tmpArray[indexPath.row])
        return cell
    }
    
    
    /*--------------------------------------*/
    /*---------------OVERRIDE---------------*/
    /*--------------------------------------*/
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
        },completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            if (self.backgroundId == 2)
            {
                UIGraphicsBeginImageContext(self.topView.frame.size)
                UIImage(named: "alliance_background")?.draw(in: self.topView.bounds)
                let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                self.topView.backgroundColor = UIColor(patternImage: image)
            }
            else if self.backgroundId == 3
            {
                UIGraphicsBeginImageContext(self.topView.frame.size)
                UIImage(named: "assembly_background")?.draw(in: self.topView.bounds)
                let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                self.topView.backgroundColor = UIColor(patternImage: image)
            }
            else if self.backgroundId == 4
            {
                UIGraphicsBeginImageContext(self.topView.frame.size)
                UIImage(named: "order_background")?.draw(in: self.topView.bounds)
                let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                self.topView.backgroundColor = UIColor(patternImage: image)
            }
            else if self.backgroundId == 1
            {
                UIGraphicsBeginImageContext(self.topView.frame.size)
                UIImage(named: "federation_background")?.draw(in: self.topView.bounds)
                let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                self.topView.backgroundColor = UIColor(patternImage: image)
            }
            else
            {
                UIGraphicsBeginImageContext(self.topView.frame.size)
                UIImage(named: "default_background")?.draw(in: self.topView.bounds)
                let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                self.topView.backgroundColor = UIColor(patternImage: image)
            }
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        api42Controller?.getCoallition(user_id: (profile?.login)!) {
            id in
            self.backgroundId = id
            if (id == 2)
            {
                DispatchQueue.main.async {
                    UIGraphicsBeginImageContext(self.topView.frame.size)
                    UIImage(named: "alliance_background")?.draw(in: self.topView.bounds)
                    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                    UIGraphicsEndImageContext()
                    self.topView.backgroundColor = UIColor(patternImage: image)
                }
            }
            else if id == 3
            {
                DispatchQueue.main.async {
                    UIGraphicsBeginImageContext(self.topView.frame.size)
                    UIImage(named: "assembly_background")?.draw(in: self.topView.bounds)
                    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                    UIGraphicsEndImageContext()
                    self.topView.backgroundColor = UIColor(patternImage: image)
                }
            }
            else if id == 4
            {
                DispatchQueue.main.async {
                    UIGraphicsBeginImageContext(self.topView.frame.size)
                    UIImage(named: "order_background")?.draw(in: self.topView.bounds)
                    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                    UIGraphicsEndImageContext()
                    self.topView.backgroundColor = UIColor(patternImage: image)
                }
            }
            else if id == 1
            {
                DispatchQueue.main.async {
                    UIGraphicsBeginImageContext(self.topView.frame.size)
                    UIImage(named: "federation_background")?.draw(in: self.topView.bounds)
                    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                    UIGraphicsEndImageContext()
                    self.topView.backgroundColor = UIColor(patternImage: image)
                }
            }
            else
            {
                DispatchQueue.main.async {
                    UIGraphicsBeginImageContext(self.topView.frame.size)
                    UIImage(named: "default_background")?.draw(in: self.topView.bounds)
                    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                    UIGraphicsEndImageContext()
                    self.topView.backgroundColor = UIColor(patternImage: image)
                }
            }
        }
        if let arr = profile?.projects_users
        {
            tmpArray = arr
        }
        displayTopView()
        
        
//        print (profile?.projects_users as Any)
//        print (profile as Any)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
