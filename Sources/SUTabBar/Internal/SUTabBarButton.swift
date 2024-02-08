//
//  SUTabBarButton.swift
//  SUTabBar
//
//  Created by Sinan Ulusoy on 6.12.2023.
//

import UIKit


// MARK: - SUTabBarButton

final class SUTabBarButton: UIButton {

    // MARK: - Initializer

    init(item: UITabBarItem) {
        super.init(frame: .zero)
        self.item = item
        setUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }
    
    // MARK: - Internals
    
    let indicatorView = UIView()
    let iconImageView = UIImageView()
    let label = UILabel()

    
    // MARK: - Privates
    
    private var item: UITabBarItem?

    private var labelUnfoldedTrailingConstraint: NSLayoutConstraint!
    private var iconImageViewFoldedTrailingConstraint: NSLayoutConstraint!
    private var labelUnfoldedLeadingConstraint: NSLayoutConstraint!
}


// MARK: - UI SetUp

extension SUTabBarButton {
    
    private func setUpUI() {
        setUpView()
        setUpHierarchy()
        setUpLayout()
    }
    
    private func setUpView() {
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.image = item?.selectedImage?.withRenderingMode(.alwaysTemplate)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false

        label.text = item?.title
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpHierarchy() {
        addSubview(indicatorView)
        addSubview(iconImageView)
        addSubview(label)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            indicatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            indicatorView.topAnchor.constraint(equalTo: topAnchor),
            indicatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SUSpacing.xxLarge),
            
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        iconImageViewFoldedTrailingConstraint = iconImageView.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -SUSpacing.xxLarge
        )
        labelUnfoldedLeadingConstraint = label.leadingAnchor.constraint(
            equalTo: iconImageView.trailingAnchor,
            constant: label.text?.isEmpty ?? true ? .zero : SUSpacing.small
        )
        labelUnfoldedTrailingConstraint = label.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -SUSpacing.xxLarge
        )
    }
}


// MARK: - View Configurations

extension SUTabBarButton {
    
    private func configureIndicatorView() {
        indicatorView.layer.cornerRadius = indicatorView.bounds.height / 2.0
        indicatorView.layer.masksToBounds = true
    }
}


// MARK: - Override Functions

extension SUTabBarButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureIndicatorView()
    }
}


// MARK: - (Un)fold operations

extension SUTabBarButton {
    
    func toggleItem(_ isFolded: Bool) {
        isFolded ? unfold() : fold()
    }
    
    private func fold() {
        labelUnfoldedLeadingConstraint.isActive = false
        labelUnfoldedTrailingConstraint.isActive = false
        iconImageViewFoldedTrailingConstraint.isActive = true

        UIView.animate(withDuration: Constant.animationDuration) {
            self.label.alpha = .zero
            self.indicatorView.alpha = .zero
        }
    }

    private func unfold() {
        iconImageViewFoldedTrailingConstraint.isActive = false
        labelUnfoldedLeadingConstraint.isActive = true
        labelUnfoldedTrailingConstraint.isActive = true
        
        UIView.animate(withDuration: Constant.animationDuration, delay: Constant.animationDuration, animations: {
            self.label.alpha = 1.0
            self.indicatorView.alpha = 1.0
        })
    }
}


// MARK: - Constants

extension SUTabBarButton {
    
    private enum Constant {
        static let animationDuration: CGFloat = 0.15
    }
}
