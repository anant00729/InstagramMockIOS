//
//  LoginController.swift
//  InstagramFirebase
//
//  Created by anantawasthy on 29/07/18.
//  Copyright © 2018 anantawasthy. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    let logoContainerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        
        let logoImageView = UIImageView(image: UIImage(named: "Instagram_logo_white"))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(logoImageView)
        
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }()
    
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    @objc func handleTextInputChange(){
        let isValid = emailTextField.text?.count ?? 0 > 0 &&
            passwordTextField.text?.count ?? 0 > 0
        
        if isValid{
            btn_signin.isEnabled = true
            btn_signin.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        }else {
            btn_signin.isEnabled = false
            btn_signin.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
        
    }
    
    
    let btn_signin : UIButton = {
        let btn = UIButton(type : .system)
        btn.setTitle("Login", for: .normal)
        btn.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.white, for: .normal)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(onSignInClicked), for: .touchUpInside)
        return btn
    }()
    
    @objc fileprivate func onSignInClicked(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("error occured ", error)
                return
            }
            guard let mainC = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
            mainC.setUpViewController()
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    
    let signUpButton : UIButton = {
        let button = UIButton(type: .system)
        
        let left: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.lightGray
        ]
        
        let right: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.rgb(red: 0, green: 120, blue: 175),
        ]
        
        let attributedText = NSMutableAttributedString(string: "Dont have an account? ", attributes: left)
        attributedText.append(NSAttributedString(string : "Sign Up." , attributes : right))
        button.setAttributedTitle(attributedText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSignUpClicked), for: .touchUpInside)
        return button
    }()
    
    
    @objc func handleSignUpClicked(){
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(logoContainerView)
        
        
        logoContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        logoContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        logoContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        logoContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        setupInputFields()
        view.addSubview(signUpButton)
        signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
    }
    
    fileprivate func setupInputFields(){
        let sv = UIStackView(arrangedSubviews: [emailTextField, passwordTextField , btn_signin])
        sv.axis = .vertical
        sv.spacing = 10
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(sv)
        
        sv.topAnchor.constraint(equalTo: logoContainerView.bottomAnchor,constant : 40).isActive = true
        sv.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        sv.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        sv.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
