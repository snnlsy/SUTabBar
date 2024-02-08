//
//  SUTabBar.swift
//  SUTabBar
//
//  Created by Sinan Ulusoy on 6.12.2023.
//

import UIKit


// MARK: - SUTabBar

final class SUTabBar: UITabBar {
    
    // MARK: - Privates

    private var buttonList: [SUTabBarButton] = []
        
    private let containerView = UIView()
}


// MARK: - UI SetUp

extension SUTabBar {
    
    private func setUpUI() {
        setUpView()
        setUpHierarchy()
        setUpLayout()
    }
    
    private func setUpView() {
        backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        buttonList = items?.map { createButton(for: $0) } ?? []
        removeDefaultItems()
    }
    
    private func setUpHierarchy() {
        addSubview(containerView)
        buttonList.forEach { containerView.addSubview($0) }
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: SUSpacing.xxLarge),
            containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -SUSpacing.xxLarge),
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])

        buttonList.first?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SUSpacing.xxLarge).isActive = true
        buttonList.last?.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SUSpacing.xxLarge).isActive = true
        buttonList.forEach { button in
            button.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        }

        var layoutGuideList: [UILayoutGuide] = []
        for (currentButton, nextButton) in zip(buttonList, buttonList.dropFirst()) {
            let layoutGuide = UILayoutGuide()
            containerView.addLayoutGuide(layoutGuide)
            layoutGuideList.append(layoutGuide)
            NSLayoutConstraint.activate([
                layoutGuide.leadingAnchor.constraint(equalTo: currentButton.trailingAnchor),
                layoutGuide.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor),
                layoutGuide.widthAnchor.constraint(equalTo: layoutGuideList.first!.widthAnchor)
            ])
        }
    }
    
    private func removeDefaultItems() {
        subviews.filter {
            String(describing: type(of: $0)) == "UITabBarButton"
        }.forEach {
            $0.removeFromSuperview()
        }
    }
}


// MARK: - View Configurations

extension SUTabBar {
    
    private func configureContainerView() {
        containerView.layer.cornerRadius = containerView.bounds.height / 2.0
        containerView.layer.masksToBounds = true
    }
}


// MARK: - Override Properties

extension SUTabBar {
    
    // MARK: - Default Properties

    override var selectedItem: UITabBarItem? {
        didSet {
            guard let selectedItem,
                  let index = items?.firstIndex(of: selectedItem) else { return }
            selectItem(at: index)
        }
    }
        
    override var backgroundColor: UIColor? {
        get { containerView.backgroundColor }
        set { containerView.backgroundColor = newValue }
    }
    
    // MARK: - Custom Properties
    
    override var indicatorColor: UIColor? {
        get { buttonList.first?.indicatorView.backgroundColor }
        set { buttonList.forEach { $0.indicatorView.backgroundColor = newValue } }
    }
    
    override var iconColor: UIColor? {
        get { buttonList.first?.iconImageView.tintColor }
        set { buttonList.forEach { $0.iconImageView.tintColor = newValue } }
    }
    
    override var titleColor: UIColor? {
        get { buttonList.first?.currentTitleColor }
        set { buttonList.forEach { $0.label.textColor = newValue } }
    }
    
    override var titleFont: UIFont? {
        get { buttonList.first?.label.font }
        set { buttonList.forEach { $0.label.font = newValue } }
    }
}


// MARK: - Override Functions

extension SUTabBar {

    override func setItems(_ items: [UITabBarItem]?, animated: Bool) {
        super.setItems(items, animated: animated)
        setUpUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureContainerView()
    }
}


// MARK: - Button Functions

extension SUTabBar {
    
    private func createButton(for item: UITabBarItem) -> SUTabBarButton {
        let button = SUTabBarButton(item: item)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    @objc
    private func didTapButton(button: SUTabBarButton) {
        guard let index = buttonList.firstIndex(of: button),
              let item = items?[index] else { return }
        delegate?.tabBar?(self, didSelect: item)
    }
    
    private func selectItem(at index: Int) {
        buttonList.indices.forEach { buttonList[$0].toggleItem($0 == index) }
        UIView.animate(withDuration: Constant.animationDuration) {
            self.containerView.layoutIfNeeded()
        }
    }
}


// MARK: - Constants

extension SUTabBar {
    
    private enum Constant {
        static let animationDuration: CGFloat = 0.4
    }
}
