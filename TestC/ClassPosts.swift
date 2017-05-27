//
//  ClassPosts.swift
//  TestC
//
//  Created by PEDRO ARMANDO MANFREDI on 23/5/17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation

class ClassPosts {
    
    let userId : Int
    let id : Int
    let title : String
    let body : String
    
    init(dictionary : [String : AnyObject]) {
        userId = dictionary["userId"] as? Int ?? 0
        id = dictionary["id"] as? Int ?? 0
        title = dictionary["title"] as? String ?? ""
        body = dictionary["body"] as? String ?? ""
    }
}
