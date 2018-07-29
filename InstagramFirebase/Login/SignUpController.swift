//
//  ViewController.swift
//  InstagramFirebase
//
//  Created by anantawasthy on 26/07/18.
//  Copyright © 2018 anantawasthy. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    let plusPhotoButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(onAddPicClicked), for: .touchUpInside)
        return btn
    }()
    
    let signInButton : UIButton = {
        let button = UIButton(type: .system)
        
        let left: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.lightGray
        ]
        
        let right: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.rgb(red: 0, green: 120, blue: 175),
        ]
        
        let attributedText = NSMutableAttributedString(string: "Already have an account? ", attributes: left)
        attributedText.append(NSAttributedString(string : "Sign In." , attributes : right))
        button.setAttributedTitle(attributedText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onSignInClick), for: .touchUpInside)
        return button
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
                       passwordTextField.text?.count ?? 0 > 0 &&
                       usernameTextField.text?.count ?? 0 > 0
        if isValid{
            btn_reg.isEnabled = true
            btn_reg.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        }else {
            btn_reg.isEnabled = false
            btn_reg.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
        
    }
    
    let usernameTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
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
    
    let btn_reg : UIButton = {
        let btn = UIButton(type : .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.white, for: .normal)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(onSignUpClicked), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(plusPhotoButton)
        navigationController?.navigationBar.isHidden = true
        //view.addSubview(emailTextField)
        view.backgroundColor = UIColor.white
        
        plusPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        plusPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        setupInputFields()
        
        view.addSubview(signInButton)
        
        signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        signInButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        signInButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
    }
    
    fileprivate func setupInputFields(){
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, btn_reg])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 20).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        
    }
    
    @objc private func onAddPicClicked(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            plusPhotoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 3
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func onSignUpClicked(){
        
        guard let email = emailTextField.text , email.count > 0 else { return }
        guard let password = passwordTextField.text , password.count > 0 else { return }
        guard let username = usernameTextField.text , username.count > 0 else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("Failed to create the user", error)
                return
            }
            
            //print("Succesfully created the user " , user?.uid ?? "uid not found")
            
            
            guard let imageUpload = self.plusPhotoButton.imageView?.image else {return}
            let fileName = NSUUID().uuidString
            if let data = imageUpload.jpegData(compressionQuality: 0.75) {
                Storage.storage().reference().child("profile_images").child(fileName).putData(data, metadata: nil, completion: { (metadata, error) in
                    if let error = error {
                        print("Failed to upload the image", error)
                    }
                    
                    guard let profileImageMetaData = metadata?.downloadURL()?.absoluteString else { return }
                    
                    
                    guard let uid = user?.uid else { return }
                    let userDetails = ["username" : username, "profileImageURL" : profileImageMetaData]
                    let value = [uid : userDetails]
        
                    Database.database().reference().child("users").updateChildValues(value, withCompletionBlock: { (err, ref) in
                        if let err = err {
                            print("Failed to save user info into DB! " , err)
                            return
                        }
        
                        
                    })

                    guard let mainC = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
                    mainC.setUpViewController()
                    self.dismiss(animated: true, completion: nil)
                })
                
            }
        }
    }
    
    @objc fileprivate func onSignInClick(){
        navigationController?.popViewController(animated: true)
    }
}

