//
//  ProfileViewController.swift
//  BigSoftyApp
//
//  Created by Kailash on 11/10/18.
//  Copyright © 2018 Kailash. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UICollectionViewController {
    
    let signOutButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Out", for: .normal)
        btn.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleSignOut(){
        do {
           try Auth.auth().signOut()
            self.present(LoginViewController(), animated: true, completion: nil)
        } catch let error as NSError{
            print("Sign out failed with error ", error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(signOutButton)
        signOutButton.anchor(left: view.leftAnchor, right: view.rightAnchor, top: view.topAnchor, bottom: view.bottomAnchor, paddingLeft: 0, paddingRight: 0, paddingTop: 0, paddingBottom: 0, width: 0, height: 0)
        
    }
}
