//
//  LoginViewController.swift
//  BigSoftyApp
//
//  Created by Kailash on 11/9/18.
//  Copyright © 2018 Kailash. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let logoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 245/255, green: 94/255, blue: 94/255, alpha: 1.0)
        return view
    }()
    
    let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "bigSoftyLogo").withRenderingMode(.alwaysOriginal);
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(logoView)
        self.view.addSubview(logoImageView)
        logoView.anchor(left: view.leftAnchor, right: view.rightAnchor, top: view.topAnchor, bottom: nil, paddingLeft: 0, paddingRight: 0, paddingTop: 0, paddingBottom: 0, width: 0, height: self.view.bounds.height/2);
        logoImageView.anchor(left: logoView.leftAnchor, right: logoView.rightAnchor, top: logoView.topAnchor, bottom: logoView.bottomAnchor, paddingLeft: 0, paddingRight: 0, paddingTop: 0, paddingBottom: 0, width: 0, height: 0)
    }
}
