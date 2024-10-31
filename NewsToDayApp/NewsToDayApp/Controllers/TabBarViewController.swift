//
//  TabBarViewController.swift
//  NewsToDayApp
//
//  Created by Павел Широкий on 20.10.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        
    }

    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: BrowseViewController(), image: UIImage.home),
            generateVC(viewController: CategoriesViewController(), image: UIImage.apps),
            generateVC(viewController: UINavigationController(rootViewController: BookmarksViewController()), image: UIImage.bookmark),
            generateVC(viewController: UINavigationController(rootViewController:ProfileViewController()), image: UIImage.profile)
        ]
    }

    private func generateVC(viewController: UIViewController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        return viewController
    }
}
