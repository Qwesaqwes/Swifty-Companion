//
//  42ApiController.swift
//  Swifty Companion
//
//  Created by Jimmy CHEN-MA on 10/15/18.
//  Copyright © 2018 Jimmy CHEN-MA. All rights reserved.
//

import Foundation

class Api42Controller
{
    let Customer_key = "70af3f716254552c74659b5fd0866dbf4ca239b180fd0f0816b7afe2112555b9"
    let Customer_secret = "3ef718d405aa812b3a1edc8c7958919d3d08c2073295840139afec872f744404"
    
    var token:String?
    var viewController:ViewController?
    
//    var test:Bool = false

    func getToken()
    {
        let KeyString = String(Customer_key + ":" + Customer_secret)
        let Bearer = (KeyString.data(using: String.Encoding.utf8))?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        let url = NSURL(string: "https://api.intra.42.fr/oauth/token")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Basic " + Bearer!, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = ("grant_type=client_credentials").data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {
            data, response, error in
            if let err = error {
                print (err)
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options:JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        print (dic)
                        
//                        if self.test == false
//                        {
//                            print ("enter expire token")
//                            self.token = "ad9ccd49d63be631ebc6c00a60b664eac4e6e71c328e727a83c792c62027ced2"
//                        }
//                        else
//                        {
//                            print ("enter refresh token")
                            self.token = (dic["access_token"] as! String)
//                        }
                        
                    }
                }
                catch (let err) {
                    print ("didnt enter dictionary")
                    print (err)
                }
            }
        }
        task.resume()
    }
    
    func searchUser(login:String)
    {
        let trimmedString = login.replacingOccurrences(of: " ", with: "")
        let url = URL(string: "https://api.intra.42.fr/v2/users/" + trimmedString.lowercased())
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if let err = error {
                print (err)
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options:JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let _ = dic["message"] as? String
                        {
//                            self.test = true
                            self.getToken()
                            self.searchUser(login: login)
                        }
                        else
                        {
                            do {
                                let decoder = JSONDecoder()
                                if let user = try decoder.decode(Profile.self, from: d) as Profile? {
                                    if login.lowercased().compare(user.login.lowercased()).rawValue == 0
                                    {
                                        //login searched is correct, need to display new view with the information of the login
                                        DispatchQueue.main.async {
                                            self.viewController?.performSegue(withIdentifier: "userSegue", sender: user)
                                        }
                                    }
                                }
                            }
                            catch (let err)
                            {
                                print (err)
                                DispatchQueue.main.async {
                                    self.viewController?.loginNotFound()
                                }
                            }
                        }
                    }
                }
                catch (let err) {
                    print (err)
                    DispatchQueue.main.async {
                        self.viewController?.loginNotFound()
                    }
                }
            }
        }
        task.resume()
    }
    
    func getCoallition(user_id:String, action:@escaping (Int)->Void)
    {
        let url = URL(string: "https://api.intra.42.fr/v2/users/" + user_id + "/coalitions?sort=user_id")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if let err = error {
                print (err)
            }
            else if let d = data {
                do {
                    if let dic = try JSONSerialization.jsonObject(with: d, options:[]) as? [NSDictionary] {
                        print (dic.first as Any)
                        print (dic.first?.value(forKey: "name") as Any)
                        if let id = dic.first?.value(forKey: "id")
                        {
                            action(id as! Int)
                        }
                        else
                        {
                            action(0)
                        }
//                        action((dic.first?.value(forKey: "id") as? Int)!)
                        return
                    }
                    print ("ADF")
                }
                catch (let err) {
                    print (err)
                }
            }
        }
        task.resume()
    }
}
