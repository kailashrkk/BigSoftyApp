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

class SignUpViewController: UIViewController {
    
    let logoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 245/255, green: 94/255, blue: 94/255, alpha: 1.0)
        return view
    }()
    
    let profileImage: UIImageView = {
        let img = UIImageView()
        img.layer.borderWidth = 2.0
        img.layer.borderColor = UIColor.black.cgColor
        img.image = #imageLiteral(resourceName: "profile_picture")
        return img
    }()
    
    let addprofileImage: UIButton = {
        let btn = UIButton()
       btn.setImage(#imageLiteral(resourceName: "add-user"), for: .normal)
        btn.addTarget(self, action: #selector(handleProfilePicture), for: .touchUpInside)
        return btn
    }()
    
    let emailTextField: UITextField = {
        let user = UITextField()
        user.placeholder = "Enter Email"
        user.textAlignment = .center
        user.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        user.layer.cornerRadius = 5.0
        return user
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
    
    let verifyPasswordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = "Verify Password"
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
        btn.setTitle("Sign Up", for: .normal)
        btn.titleLabel?.tintColor = .white
        btn.layer.cornerRadius = 5.0
        btn.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return btn
    }()
    
    let termsAndConditionsButton: UIButton = {
        let btn = UIButton()
        let attributedTitle = NSMutableAttributedString(string: "By Signing Up you agree to our", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10), NSAttributedStringKey.foregroundColor: UIColor(red: 245/255, green: 94/255, blue: 94/255, alpha: 1.0)])
        attributedTitle.append(NSAttributedString(string: " "))
        attributedTitle.append(NSAttributedString(string: "Terms & Conditions", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10), NSAttributedStringKey.foregroundColor: UIColor.blue]))
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.addTarget(self, action: #selector(handleTermsAndConditions), for: .touchUpInside)
        return btn
    }()
    
    let loginSegueBtn: UIButton = {
        let btn = UIButton()
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor(red: 245/255, green: 94/255, blue: 94/255, alpha: 1.0)])
        attributedTitle.append(NSAttributedString(string: " "))
        attributedTitle.append(NSAttributedString(string: "Login", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.blue]))
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTopView()
        setupBottomView()
    }
    //TODO: Handle Logic here
    @objc func handleProfilePicture(){
        print("Upload profile picture")
    }
    
    @objc func handleSignup(){
        print("Handle signup and segue to mainvc")
        guard let emailText = emailTextField.text else {return}
        guard let userText = usernameTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let verifyPassword = verifyPasswordTextField.text else {return}
        
        if emailText.count > 0 && userText.count > 0 && password.count > 0 && verifyPassword.count > 0 {
            Auth.auth().createUser(withEmail: emailText, password: password) { (FirUser, err) in
                if let error = err {
                    print("There was an error in the register function ", error)
                }
                guard let uid = Auth.auth().currentUser?.uid else {return}
                print("Successfully signed up, here is Fire Auth: ", uid)
                let userDictionary: [String: Any] = ["email": emailText, "username": userText, "password": password]
                Database.database().reference().child("users").child(uid).updateChildValues(userDictionary, withCompletionBlock: { (err, _) in
                    self.dismiss(animated: true, completion: nil)
                })
            }
            
        }else{
            showAlertAndDismiss(alert: "Please make sure all details are entered correctly")
        }
    }
    
    @objc func handleDismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTermsAndConditions(){
        print("Terms and conditions added")
    }
    //MARK: Private Functions
    private func setupTopView(){
        self.view.addSubview(logoView)
        self.view.addSubview(profileImage)
        self.view.addSubview(addprofileImage)
        self.logoView.anchor(left: view.leftAnchor, right: view.rightAnchor, top: view.topAnchor, bottom: nil, paddingLeft: 0, paddingRight: 0, paddingTop: 0, paddingBottom: 0, width: 0, height: self.view.bounds.height/2);
        
        self.profileImage.translatesAutoresizingMaskIntoConstraints = false
        self.profileImage.centerXAnchor.constraint(equalTo: self.logoView.centerXAnchor).isActive = true
        self.profileImage.centerYAnchor.constraint(equalTo: self.logoView.centerYAnchor).isActive = true
        self.profileImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.profileImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.profileImage.layer.cornerRadius = 100
        self.profileImage.clipsToBounds = true
        
        self.addprofileImage.anchor(left: logoView.leftAnchor, right: logoView.rightAnchor, top: logoView.topAnchor, bottom: logoView.bottomAnchor, paddingLeft: 0, paddingRight: 0, paddingTop: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    private func setupBottomView(){
        
        self.view.addSubview(loginSegueBtn)
        
        self.loginSegueBtn.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: nil, bottom: self.view.bottomAnchor, paddingLeft: 40, paddingRight: -40, paddingTop: 0, paddingBottom: -20, width: 0, height: 0)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,usernameTextField, passwordTextField,verifyPasswordTextField, alertText, submitButton,termsAndConditionsButton])
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
