//
//  LoginViewController.swift
//  BigSoftyApp
//
//  Created by Kailash on 11/9/18.
//  Copyright © 2018 Kailash. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

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
    
    let usernameTextField: UITextField = {
        let user = UITextField()
        user.placeholder = "Enter Username"
        user.textAlignment = .center
        user.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        user.layer.cornerRadius = 5.0
        return user
    }()
    
    let passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = "Enter Password"
        password.textAlignment = .center
        password.isSecureTextEntry = true
        password.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        password.layer.cornerRadius = 5.0
        return password
    }()
    
    let alertText: UITextView = {
       let txt = UITextView()
        txt.text = ""
        txt.textAlignment = .center
        txt.isEditable = false
        txt.textColor = UIColor(red: 255/255, green: 94/255, blue: 94/255, alpha: 1.0)
        return txt
    }()
    
    let submitButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(red: 245/255, green: 94/255, blue: 94/255, alpha: 1.0)
        btn.setTitle("Login", for: .normal)
        btn.titleLabel?.tintColor = .white
        btn.layer.cornerRadius = 5.0
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    let loginSegueBtn: UIButton = {
       let btn = UIButton()
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor(red: 245/255, green: 94/255, blue: 94/255, alpha: 1.0)])
        attributedTitle.append(NSAttributedString(string: " "))
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.blue]))
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTopView()
        setupBottomView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (Auth.auth().currentUser?.uid != nil){
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    //TODO: Handle logic here
    @objc func handleLogin(){
        print("Handle login and segue to mainvc")
        guard let usernametext = usernameTextField.text else {return}
        guard let passwordText = passwordTextField.text else {return}
        if usernametext.count <= 0 || passwordText.count <= 0 {
           showAlertAndDismiss(alert: "Please enter a valid username or password")
            return
        }
        Auth.auth().signIn(withEmail: usernametext, password: passwordText, completion: { (data, err) in
            if let error = err {
                print("There was an error in the register function ", error)
            }
            guard let uid = Auth.auth().currentUser?.uid else {return}
            print("Successfully signed up, here is Fire Auth: ", uid)
//            let userDictionary: [String: Any] = ["email": emailText, "username": userText, "password": password]
//            Database.database().reference().child("users").child(uid).updateChildValues(userDictionary, withCompletionBlock: { (err, _) in
                self.dismiss(animated: true, completion: nil)
//            })
        })
    }
    
    @objc func handleSignUp(){
        self.present(SignUpViewController(), animated: true) {
            print("Showing sign up controller")
        }
    }
    //MARK: Private functions
    private func setupTopView(){
        self.view.addSubview(logoView)
        self.view.addSubview(logoImageView)
        self.logoView.anchor(left: view.leftAnchor, right: view.rightAnchor, top: view.topAnchor, bottom: nil, paddingLeft: 0, paddingRight: 0, paddingTop: 0, paddingBottom: 0, width: 0, height: self.view.bounds.height/2);
        self.logoImageView.anchor(left: logoView.leftAnchor, right: logoView.rightAnchor, top: logoView.topAnchor, bottom: logoView.bottomAnchor, paddingLeft: 0, paddingRight: 0, paddingTop: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    private func setupBottomView(){
        
        self.view.addSubview(loginSegueBtn)
        
        self.loginSegueBtn.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: nil, bottom: self.view.bottomAnchor, paddingLeft: 40, paddingRight: -40, paddingTop: 0, paddingBottom: -20, width: 0, height: 0)
        
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, alertText, submitButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        self.view.addSubview(stackView)
        stackView.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.logoView.bottomAnchor, bottom: self.loginSegueBtn.topAnchor, paddingLeft: 40, paddingRight: -40, paddingTop: 20, paddingBottom: -20, width: 0, height: 0)
    }
    
    func showAlertAndDismiss(alert alertText:String){
        self.alertText.text = alertText
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (_) in
            self.alertText.text = ""
        }
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
