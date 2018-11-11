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
        btn.backgroundColor = UIColor.blue
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
        collectionView?.backgroundColor = .white
        view.addSubview(signOutButton)
        signOutButton.anchor(left: view.leftAnchor, right: nil, top: view.topAnchor, bottom: nil, paddingLeft: 0, paddingRight: 0, paddingTop: 0, paddingBottom: 0, width: view.frame.width, height: 250)
        
    }
}
