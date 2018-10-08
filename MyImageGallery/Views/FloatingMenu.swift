//
//  SelectionControl.swift
//  MyImageGallery
//
//  Created by Abhirup on 07/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

protocol SelectionControlDelegate {
    func getPictures(with Category: Constants.ImageCategory)
    func showViralPictures()
    func hideViralPictures()
}

class FloatingMenu: UIView {
    
    var delegate: SelectionControlDelegate?
    
    var isViral: Bool = true {
        didSet {
            isViral = !isViral
            setViralButtonImage()
        }
    }
    var imageCategory: Constants.ImageCategory? {
        didSet {
            //set image if either 'hot' or 'top' based on current selection
            setImageCategoryButtonImage()
        }
    }
    
    let fullScreenOverlay: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        return view
    }()
    
    let menuButton: FloatingButton = {
        let button = FloatingButton()
        button.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return button
    }()
    
    lazy var imageCategorySelectionButton: FloatingButton = {
       let button = FloatingButton()
        button.addTarget(self, action: #selector(handlePopularitySelection), for: .touchUpInside)
        return button
    }()
    
    let viralToggleButton: FloatingButton = {
        let button = FloatingButton()
        button.setImage(UIImage(named: "viral")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(handleViralSelection), for: .touchUpInside)
        return button
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
        fullScreenOverlay.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeView)))
    }

    private func setupViews() {
        addSubview(fullScreenOverlay)
        
        fullScreenOverlay.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        addSubview(menuButton)
        menuButton.anchor(top: nil, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 0, width: 70, height: 70)
        
        addSubview(imageCategorySelectionButton)
        imageCategorySelectionButton.anchor(top: nil, left: safeAreaLayoutGuide.leftAnchor, bottom: menuButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 0, width: 70, height: 70)
        
        addSubview(viralToggleButton)
        viralToggleButton.anchor(top: nil, left: safeAreaLayoutGuide.leftAnchor, bottom: imageCategorySelectionButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 0, width: 70, height: 70)
    }
    
    
    @objc private func handlePopularitySelection() {
        if imageCategory == .top {
            imageCategory = .hot
            delegate?.getPictures(with: .hot)
        } else if imageCategory == .hot {
            imageCategory = .top
            delegate?.getPictures(with: .top)
        }

        closeView()
    }

    @objc private func handleViralSelection() {
        isViral = !isViral
        isViral ? delegate?.showViralPictures() : delegate?.hideViralPictures()

        closeView()
    }

    @objc private func closeView() {
        self.removeFromSuperview()
    }
    
    
    private func setImageCategoryButtonImage() {
        if imageCategory == .hot {
            imageCategorySelectionButton.setImage(UIImage(named: "top")?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            imageCategorySelectionButton.setImage(UIImage(named: "hot")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }

    
    private func setViralButtonImage() {
        
        if isViral {
            viralToggleButton.backgroundColor = .appThemeColor
        } else {
            viralToggleButton.backgroundColor = .gray
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

