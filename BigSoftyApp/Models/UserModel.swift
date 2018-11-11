//
//  UserModel.swift
//  BigSoftyApp
//
//  Created by Kailash on 11/11/18.
//  Copyright © 2018 Kailash. All rights reserved.
//

import Foundation

struct User {
    let uid: String
    let profileImage: String
    let username: String
    
    init(dictionary:[String:Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImage = dictionary["profileImageURL"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
    }
}
