//
//  CustomHeader.swift
//  MyImageGallery
//
//  Created by Abhirup on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

protocol CustomHeaderDelegate {
    func didSelectFilter()
    func didSelectGridLayout()
    func didSelectListLayout()
    func didSelectMasonryLayout()
}

class CustomHeader: UICollectionViewCell {

    var delegate: CustomHeaderDelegate?
    
    @IBOutlet weak var filterButton: UIButton! {
        didSet {
            filterButton.addTarget(self, action: #selector(handleFilterSelect), for: .touchUpInside)
        }
    }

    
    @IBOutlet weak var gridButton: UIButton! {
        didSet {
            gridButton.addTarget(self, action: #selector(handleGridLayoutSelect), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var listButton: UIButton! {
        didSet {
            listButton.addTarget(self, action: #selector(handleListLayoutSelect), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var masonryButton: UIButton! {
        didSet {
            masonryButton.addTarget(self, action: #selector(handleMasonryLayoutSelect), for: .touchUpInside)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        addBlurrBackground()

        updateColorOnSelection(for: gridButton)
    }
    
    func layoutChanged(to type: Constants.LayoutType) {
        switch type {
        case .grid:
            handleGridLayoutSelect()
        case .list:
            handleListLayoutSelect()
        case .masonry:
            handleMasonryLayoutSelect()
        }
    }
    
    @objc private func handleFilterSelect() {
        delegate?.didSelectFilter()
    }

    @objc private func handleGridLayoutSelect() {
        updateColorOnSelection(for: gridButton)
        delegate?.didSelectGridLayout()
    }
    
    @objc private func handleListLayoutSelect() {
        updateColorOnSelection(for: listButton)
        delegate?.didSelectListLayout()
    }

    @objc private func handleMasonryLayoutSelect() {
        updateColorOnSelection(for: masonryButton)
        delegate?.didSelectMasonryLayout()
    }

    private func addBlurrBackground() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(blurEffectView, at: 0)
    }
    
    private func updateColorOnSelection(for button: UIButton) {
        gridButton.tintColor = .lightGray
        listButton.tintColor = .lightGray
        masonryButton.tintColor = .lightGray
        
        button.tintColor = UIColor.appThemeColor
    }

}
