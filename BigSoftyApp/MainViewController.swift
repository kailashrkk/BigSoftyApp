//
//  ViewController.swift
//  BigSoftyApp
//
//  Created by Kailash on 11/9/18.
//  Copyright © 2018 Kailash. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MainViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .red
        setupTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Check for user and then present login if empty
       // try! Auth.auth().signOut()
        if Auth.auth().currentUser?.uid == nil {
            self.present(LoginViewController(), animated: true, completion: nil);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupTabBar(){
        let homeViewController = UIViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home_unselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "home_selected").withRenderingMode(.alwaysOriginal));
        
        let profileViewController = ProfileViewController(collectionViewLayout: UICollectionViewLayout())
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "user_unselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "user_selected").withRenderingMode(.alwaysOriginal));
        
        let cameraViewController = UIViewController()
        cameraViewController.tabBarItem = UITabBarItem(title: "Camera", image: #imageLiteral(resourceName: "photo_camera_unselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "photo_camera").withRenderingMode(.alwaysOriginal));
        
        self.viewControllers = [homeViewController, cameraViewController, profileViewController]
    }
}

