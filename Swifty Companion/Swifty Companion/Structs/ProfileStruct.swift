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
    let id:Int
    
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

struct Coalition: Codable
{
    let name:String
    
    init (name:String)
    {
        self.name = name
    }
}
//
//extension Coalition: Decodable {
//    enum MyStructKeys: String, CodingKey { // declaring our keys
//        case Name = "name"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: MyStructKeys.self) // defining our (keyed) container
//        let fullName: String = try container.decode(String.self, forKey: .Name) // extracting the data
//        
//        self.init(name: fullName) // initializing our struct
//    }
//}

