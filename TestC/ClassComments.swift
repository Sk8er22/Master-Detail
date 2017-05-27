//
//  ClassComments.swift
//  TestC
//
//  Created by PEDRO ARMANDO MANFREDI on 23/5/17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation

class ClassComments {
    
    let postId : Int
    let id : Int
    let name : String
    let email : String
    let body : String
    
    
    init(name: String, body: String) {
        postId = 0
        id = 0
        self.name = name
        email = ""
        self.body = body
    }
    
    init(dictionary : [String : AnyObject]) {
        postId = dictionary["postId"] as? Int ?? 0
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
        email = dictionary["email"] as? String ?? ""
        body = dictionary["body"] as? String ?? ""
    }
}
