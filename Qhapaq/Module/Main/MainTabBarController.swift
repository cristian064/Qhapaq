//
//  MainTabViewController.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 18/07/21.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let homeViewController = HomeViewController()
    let userActivityViewController = UserActivityViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [createNavController(viewController: homeViewController,
                                               title: "home",
                                               imageName: "bicycle"),
        createNavController(viewController: userActivityViewController,
                            title: "Activity", imageName: "clock.arrow.circlepath")]
        
//        self.tabBar.backgroundColor = .lightGray
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = UIColor.white
            UITabBar.appearance().standardAppearance = tabBarAppearance

            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
        self.tabBar.isTranslucent = false
    }
    
    private func createNavController(viewController: UIViewController,
                                     title: String,
                                     imageName: String) -> UIViewController {
        viewController.navigationItem.title = title
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.isTranslucent = false
        navController.view.backgroundColor = .white
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}
