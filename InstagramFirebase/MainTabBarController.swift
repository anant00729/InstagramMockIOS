//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by anantawasthy on 28/07/18.
//  Copyright © 2018 anantawasthy. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            
            let layout = UICollectionViewFlowLayout()
            let pc = PhotoSelectorController(collectionViewLayout : layout)
            let navController = UINavigationController(rootViewController: pc)
            self.present(navController, animated: true, completion: nil)
            
            return false
        }else {
            return true
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
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
        
        // Home
        let navHomeController = templateViewController(selectedImage : "home_selected" , unselectedImage : "home_unselected", rootViewController: UserProfileController(collectionViewLayout : UICollectionViewFlowLayout()))
        
        // Search
        let navSearchController = templateViewController(selectedImage : "search_selected" , unselectedImage : "search_unselected")
        
        //plus nav controller
        let navPlusController = templateViewController(selectedImage: "plus_selected", unselectedImage: "plus_unselected")
        
        //like controller
        let navLikeController = templateViewController(selectedImage: "like_selected", unselectedImage: "like_unselected")
        
        // User Profile
        let layout = UICollectionViewFlowLayout()
        let userProfileVC = UserProfileController(collectionViewLayout : layout)
        let navUserProfile = UINavigationController(rootViewController: userProfileVC)
        
        navUserProfile.tabBarItem.image = UIImage(named: "profile_unselected")
        navUserProfile.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        
        tabBar.tintColor = .black
        
        viewControllers = [navHomeController, navSearchController , navPlusController , navLikeController ,navUserProfile  ]
        
        guard let items = tabBar.items else {return}
        
        for i in items{
            i.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateViewController(selectedImage : String , unselectedImage : String, rootViewController : UIViewController = UIViewController()) -> UINavigationController {
        let navViewController = UINavigationController(rootViewController: rootViewController)
        
        navViewController.tabBarItem.image = UIImage(named: unselectedImage)
        navViewController.tabBarItem.selectedImage = UIImage(named: selectedImage)
        return navViewController
    }
}
