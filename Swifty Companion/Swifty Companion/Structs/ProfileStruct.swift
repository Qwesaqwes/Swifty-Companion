//
//  ProfileStruct.swift
//  Swifty Companion
//
//  Created by Jimmy CHEN-MA on 10/16/18.
//  Copyright © 2018 Jimmy CHEN-MA. All rights reserved.
//

import Foundation

struct Profile: Codable
{
    let login:String
    let first_name:String
    let last_name:String
    let wallet:Int
    let correction_point:Int
    let location:String?
    let image_url:String
    let email:String
    
    let cursus_users:[User]
    
}

struct User: Codable
{
    let level:Float
}
