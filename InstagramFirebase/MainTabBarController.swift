//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by anantawasthy on 28/07/18.
//  Copyright © 2018 anantawasthy. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navlc = UINavigationController(rootViewController: loginController)
                self.present(navlc, animated: true, completion: nil)
            }
            return
        }
        
        setUpViewController()
    }
    
    func setUpViewController(){
        
        
        let layout = UICollectionViewFlowLayout()
        let userProfileVC = UserProfileController(collectionViewLayout : layout)
        let navUserProfile = UINavigationController(rootViewController: userProfileVC)
        
        navUserProfile.tabBarItem.image = UIImage(named: "profile_unselected")
        navUserProfile.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        
        tabBar.tintColor = .black
        
        viewControllers = [navUserProfile , UIViewController()]
    }
}
