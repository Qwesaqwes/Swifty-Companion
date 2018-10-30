//
//  ViewController.swift
//  Swifty Companion
//
//  Created by Jimmy CHEN-MA on 10/15/18.
//  Copyright © 2018 Jimmy CHEN-MA. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var api42Controller:Api42Controller?

    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    
    /*--------------------------------------*/
    /*---------------ACTION-----------------*/
    /*--------------------------------------*/
    
    @IBAction func search(_ sender: UIButton)
    {
        searchButton.isEnabled = false
        if (loginText.text != "")
        {
            api42Controller?.searchUser(login: loginText.text!)
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Login is required", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    /*--------------------------------------*/
    /*---------------FUNCTION---------------*/
    /*--------------------------------------*/
    
    func loginNotFound()
    {
        let alert = UIAlertController(title: "Error", message: "Login not found.", preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*--------------------------------------*/
    /*---------------OVERRIDE---------------*/
    /*--------------------------------------*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "userSegue"
        {
            if let vc = segue.destination as? ProfileViewController
            {
                vc.profile = (sender as! Profile)
                vc.api42Controller = api42Controller!
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
        },completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "default_background")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "default_background")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        

        loginText.layer.cornerRadius = 0.5
        searchButton.layer.cornerRadius = 5
        
        api42Controller = Api42Controller()
        api42Controller?.viewController = self
        api42Controller?.getToken()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

