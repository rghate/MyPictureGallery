//
//  TabBarController.swift
//  MyImageGallery
//
//  Created by Abhirup on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
        view.backgroundColor = .white
        tabBar.tintColor = .darkGray
        
        setupViewConrollers()
    }
    
    //MARK:- Setup functions
    
    private func setupViewConrollers() {
        let layout = UICollectionViewFlowLayout()
        
        let homeNavController = generateNavigationController(with: HomeController(collectionViewLayout: layout), title: "Home", image: #imageLiteral(resourceName: "home"))
        
        let topNavController = generateNavigationController(with: UIViewController(), title: "Top Rated", image: #imageLiteral(resourceName: "top"))
        
        let hotNavController = generateNavigationController(with: UIViewController(), title: "Hot", image: #imageLiteral(resourceName: "hot"))
        
        viewControllers = [
            homeNavController,
            topNavController,
            hotNavController
        ]
    }
    
    //MARK:- Helper functions
    
    fileprivate func generateNavigationController(with rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        return navController
    }

}
