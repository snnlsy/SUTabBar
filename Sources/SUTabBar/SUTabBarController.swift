//
//  SUTabBarController.swift
//  SUTabBar
//
//  Created by Sinan Ulusoy on 6.12.2023.
//

import UIKit


// MARK: - BubbleTabBarController Delegates

open class SUTabBarController: UITabBarController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = SUTabBar()
        self.setValue(tabBar, forKey: "tabBar")
    }
}


// MARK: - UITabBarController Delegates

extension SUTabBarController {

    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item),
              let viewController = viewControllers?[index]
        else { return }
        
        selectedIndex = index
        delegate?.tabBarController?(self, didSelect: viewController)
    }
}
