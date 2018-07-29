//
//  UserProfileHeader.swift
//  InstagramFirebase
//
//  Created by anantawasthy on 28/07/18.
//  Copyright © 2018 anantawasthy. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    
    var user : User? {
        didSet {
            
            getProfileImage()
            usernameLabel.text = user?.username
        }
    }
    
    let profileImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        return image
    }()

    let listButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "list"), for: .normal)
        return btn
    }()

    
    let gridButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "grid"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.1)
        return btn
    }()


    let bookmarkButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "ribbon"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.1)
        return btn
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postLabel : UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textAlignment = .center
        
        let top: [NSAttributedString.Key: Any] = [
            .font : UIFont.boldSystemFont(ofSize: 14)
        ]
        
        let bottom: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.lightGray,
            .font : UIFont.boldSystemFont(ofSize: 14)
        ]
        
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: top)
        attributedText.append(NSAttributedString(string : "Post" , attributes : bottom))
        label.attributedText = attributedText
        return label
    }()
    
    let followersLabel : UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textAlignment = .center
        
        let top: [NSAttributedString.Key: Any] = [
            .font : UIFont.boldSystemFont(ofSize: 14)
        ]
        
        let bottom: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.lightGray,
            .font : UIFont.boldSystemFont(ofSize: 14)
        ]
        
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: top)
        attributedText.append(NSAttributedString(string : "Followers" , attributes : bottom))
        label.attributedText = attributedText
        
        return label
    }()
    
    let followingLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        
        let top: [NSAttributedString.Key: Any] = [
            .font : UIFont.boldSystemFont(ofSize: 14)
        ]
        
        let bottom: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.lightGray,
            .font : UIFont.boldSystemFont(ofSize: 14)
        ]
        
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: top)
        attributedText.append(NSAttributedString(string : "Following" , attributes : bottom))
        label.attributedText = attributedText
        
        return label
    }()
    
    let editProfileButton : UIButton = {
        let button = UIButton(type : .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()

    fileprivate func getProfileImage(){
        guard let profileImageURL = user?.profileImageURL else {return}
        guard let url = URL(string: profileImageURL) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print("something went wrong " , error)
                return
            }
            // check for status code
            
            guard let data = data else {return}
            let image = UIImage(data: data)
            // this will take the output to the main UI thread
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
            
            }.resume()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant : 12).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant : 12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        setupBottomBar()
        addSubview(usernameLabel)
        usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant : 4).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant : 12).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant : 12).isActive = true
        usernameLabel.bottomAnchor.constraint(equalTo: listButton.topAnchor).isActive = true
        
        setupUserStats()
        addSubview(editProfileButton)
        editProfileButton.topAnchor.constraint(equalTo: postLabel.bottomAnchor, constant : 4).isActive = true
        editProfileButton.leftAnchor.constraint(equalTo: postLabel.leftAnchor, constant : 24).isActive = true
        editProfileButton.rightAnchor.constraint(equalTo: followingLabel.rightAnchor, constant : -12).isActive = true
        editProfileButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
    }
    
    
    
    fileprivate func setupBottomBar(){
        
        let topLine = UIView()
        topLine.backgroundColor = UIColor.lightGray
        topLine.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        
        let stackView = UIStackView(arrangedSubviews: [listButton, gridButton, bookmarkButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        
        addSubview(stackView)
        addSubview(topLine)
        addSubview(bottomLine)
        
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        topLine.bottomAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        topLine.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        topLine.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        topLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        bottomLine.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        bottomLine.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bottomLine.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    fileprivate func setupUserStats(){
        let stackView = UIStackView(arrangedSubviews: [postLabel, followersLabel , followingLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
