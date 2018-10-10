//
//  SelectionControl.swift
//  MyImageGallery
//
//  Created by RGhate on 07/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

//MARK: Protocol
protocol FloatingMenuDelegate {
    func didSelectPictureCategory(with category: Constants.ImageCategory)
    func didSelectViral()
    func didDeselectViral()
}

class FloatingMenu: UIView {
    
    //MARK: delegate
    var delegate: FloatingMenuDelegate?
    
    //MARK: public vatiables
    var isViral: Bool = true {
        didSet {
            isViral = !isViral
            //set viralToggleButton image based on viral selection status
            setViralButtonImage()
        }
    }
    var imageCategory: Constants.ImageCategory? {
        didSet {
            //set imageCategorySelectionButton image('hot'/'top') based on current imageCategory
            setImageCategoryButtonImage()
        }
    }
    
    //MARK: Private properties

    private let fullScreenOverlay: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.65)
        
        return view
    }()
    
    private let menuButton: FloatingButton = {
        let button = FloatingButton()
        button.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return button
    }()
    
    //button to show selectio of 'hot' or 'top' images
    private lazy var imageCategorySelectionButton: FloatingButton = {
       let button = FloatingButton()
        button.addTarget(self, action: #selector(handlePopularitySelection), for: .touchUpInside)
        return button
    }()
    
    //image category label
    private let imageCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Show Hot"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .left

        return label
    }()
    
    //toggle button to show include/exclude viral images
    private let viralToggleButton: FloatingButton = {
        let button = FloatingButton()
        button.setImage(UIImage(named: "viral")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(handleViralSelection), for: .touchUpInside)
        return button
    }()

    //image category label
    private let viralToggleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hide Viral"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
        fullScreenOverlay.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeView)))
    }

    //MARK: Private methods

    private func setupViews() {
        let buttonsize = CGSize(width: 70, height: 70)
        
        // overlay view to display a semi transparent black fullscreen background view when menu is shown
        addSubview(fullScreenOverlay)
        fullScreenOverlay.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        addSubview(menuButton)
        //place menuButton at the bottom-left corner of screen, with bottom-left padding and width-height
        menuButton.anchor(top: nil, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 0, width: buttonsize.width, height: buttonsize.height)

        
        addSubview(imageCategorySelectionButton)
        //place at bottom-left corner of screen, above menu button, with bottom and left padding
        imageCategorySelectionButton.anchor(top: nil, left: safeAreaLayoutGuide.leftAnchor, bottom: menuButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 0, width: buttonsize.width, height: buttonsize.height)

        addSubview(imageCategoryLabel)
        //place imageCategoryLabel adjacent to imageCategorySelectionButton
        imageCategoryLabel.anchor(top: nil, left: imageCategorySelectionButton.rightAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        //align imageCategoryLabel centrally vertical to imageCategorySelectionButton
        imageCategoryLabel.centerYAnchor.constraint(equalTo: imageCategorySelectionButton.centerYAnchor).isActive = true

        
        addSubview(viralToggleButton)
        //place at bottom-left corner of screen, above imageCategory button, with bottom and left padding
        viralToggleButton.anchor(top: nil, left: safeAreaLayoutGuide.leftAnchor, bottom: imageCategorySelectionButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 0, width: buttonsize.width, height: buttonsize.height)
        
        addSubview(viralToggleLabel)
        //place viralToggleLabel adjacent to viralToggleButton
        viralToggleLabel.anchor(top: nil, left: viralToggleButton.rightAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        //align viralToggleLabel centrally vertical to viralToggleButton
        viralToggleLabel.centerYAnchor.constraint(equalTo: viralToggleButton.centerYAnchor).isActive = true
    }
    
    private func setImageCategoryButtonImage() {
        if imageCategory == .hot {
            imageCategorySelectionButton.setImage(UIImage(named: "top")?.withRenderingMode(.alwaysTemplate), for: .normal)
            imageCategoryLabel.text = "Show Top"
        } else {
            imageCategorySelectionButton.setImage(UIImage(named: "hot")?.withRenderingMode(.alwaysTemplate), for: .normal)
            imageCategoryLabel.text = "Show Hot"
        }
    }

    private func setViralButtonImage() {
        
        if isViral {
            viralToggleButton.backgroundColor = .appThemeColor
            viralToggleLabel.text = "Include Viral"
        } else {
            viralToggleButton.backgroundColor = .gray
            viralToggleLabel.text = "Exclude Viral"
        }
    }

    
    //MARK: handlers

    @objc private func handlePopularitySelection() {
        if imageCategory == .top {
            imageCategory = .hot
            delegate?.didSelectPictureCategory(with: .hot)
        } else if imageCategory == .hot {
            imageCategory = .top
            delegate?.didSelectPictureCategory(with: .top)
        }

        closeView()
    }

    @objc private func handleViralSelection() {
        isViral = !isViral
        isViral ? delegate?.didSelectViral() : delegate?.didDeselectViral()

        closeView()
    }

    @objc private func closeView() {
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

