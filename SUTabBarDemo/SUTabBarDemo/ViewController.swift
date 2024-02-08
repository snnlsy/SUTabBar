//
//  ViewController.swift
//  SUTabBarDemo
//
//  Created by Sinan Ulusoy on 6.12.2023.
//

import UIKit
import SUTabBar

class ViewController: SUTabBarController {
    
    let vc1 = TestVC()
    let vc2 = TestVC()
    let vc3 = TestVC()
    let vc4 = TestVC()
    let vc5 = TestVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vc1.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "img1"), selectedImage: nil)
        vc2.tabBarItem = UITabBarItem(title: "T", image: UIImage(named: "img2"), selectedImage: nil)
        vc3.tabBarItem = UITabBarItem(title: "Test", image: UIImage(named: "img3"), selectedImage: nil)
        vc4.tabBarItem = UITabBarItem(title: "TestTest", image: UIImage(named: "img4"), selectedImage: nil)
        vc5.tabBarItem = UITabBarItem(title: "TestTestTest", image: UIImage(named: "img5"), selectedImage: nil)

        viewControllers = [vc1, vc2, vc3, vc4, vc5]
        selectedIndex = 2

        tabBar.backgroundColor = .red.withAlphaComponent(0.5)
        tabBar.indicatorColor = .yellow.withAlphaComponent(0.2)
        tabBar.titleColor = .blue
        tabBar.iconColor = .darkGray
        tabBar.titleFont = .systemFont(ofSize: 15)
    }
}


// MARK: - Dummy VC

class TestVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(
            red: .random(in: 0...1),
            green: 0.5,
            blue: 0.5,
            alpha: 0.5
        )
    }
}
