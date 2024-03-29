<p align="center">
    <a href="https://swift.org/package-manager/">
        <img src="https://img.shields.io/badge/SPM-compatible-orange" />
    </a>
    <img src="https://img.shields.io/badge/Swift-5-orange" />
</p>
<br> 
<p align="center">
  <img src="SUTabBarDemo/Demo.gif" alt="animated" />
</p>
<br> 


## Description
This library adds animation to tabbar items.


## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

```swift
dependencies: [
    .package(url: "https://github.com/snnlsy/SUTabBar.git")
]
```


## Usage

```swift
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
```

<br> 


# License
The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).