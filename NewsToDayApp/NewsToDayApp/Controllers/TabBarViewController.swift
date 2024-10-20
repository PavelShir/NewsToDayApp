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
        generateVC(viewController: BrowseViewController(), title: "Browse", image: UIImage(systemName: "house")),
        generateVC(viewController: CategoriesViewController(), title: "Categories", image: UIImage(systemName: "list.bullet.circle")),
        generateVC(viewController: BookmarksViewController(), title: "Bookmarks", image: UIImage(systemName: "bookmark")),
        generateVC(viewController: ProfileViewController(), title: "Profile", image: UIImage(systemName: "person.crop.circle"))
        ]
    }

    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
}
