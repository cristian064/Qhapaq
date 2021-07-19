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
                                               imageName: ""),
        createNavController(viewController: userActivityViewController,
                            title: "Activity", imageName: "")]
    }
    
    private func createNavController(viewController : UIViewController , title : String , imageName : String) -> UIViewController{
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
