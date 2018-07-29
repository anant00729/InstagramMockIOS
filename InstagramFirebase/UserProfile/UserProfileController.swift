//
//  UserProfileController.swift
//  InstagramFirebase
//
//  Created by anantawasthy on 28/07/18.
//  Copyright © 2018 anantawasthy. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.white
        
        //navigationItem.title = "User Profile"
        fetchUser()
        
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        setupLogOutButtton()
        
    }
    
    var user : User?
    
    fileprivate func fetchUser(){
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference()
            .child("users")
            .child(uid)
            .observeSingleEvent(of: .value, with: { (snap) in
                
                guard let dictionary = snap.value as? [String:Any] else {return}
                
                
                self.user = User(dictionary: dictionary)

                let username = self.user?.username

                self.navigationItem.title = username
                self.collectionView.reloadData()
            }) { (error) in
                print("Error : " , error)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
        
        header.user = self.user
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor.green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    fileprivate func setupLogOutButtton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(onSettingsClicked))
    }
    
    @objc func onSettingsClicked(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (_) in
            do {
                try Auth.auth().signOut()
                // we need to present somekind of login controller
                
                let lc = LoginController()
                let navC = UINavigationController(rootViewController: lc)
                self.present(navC, animated: true, completion: nil)
                
                
            }catch let signoutError {
                print(signoutError)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}

struct User {
    let username : String
    let profileImageURL : String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        print(self.username)
        self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
    }
}
