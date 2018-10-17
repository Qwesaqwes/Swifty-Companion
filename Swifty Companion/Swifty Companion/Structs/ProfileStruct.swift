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
    let projects_users:[Project]
}

struct User: Codable
{
    let level:Float
    let skills:[Skill]
}

struct Skill: Codable
{
    let level:Float
    let name:String
}

struct Project: Codable
{
    let cursus_ids:[Int]
    let final_mark:Int?
    let project:ProjectInfo
    let status:String
}

struct ProjectInfo: Codable
{
    let name:String
    let slug:String
}
