//
//  CustomHeader.swift
//  MyImageGallery
//
//  CustomHeader class displaying grid, list and masonry layout options.
//
//  Created by RGhate on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

//MARK: Protocol
protocol CustomHeaderDelegate {
    func didSelectInfo()
    func didSelectGridLayout()
    func didSelectListLayout()
    func didSelectMasonryLayout()
}

class CustomHeader: UICollectionViewCell {

    //MARK: delegate
    var delegate: CustomHeaderDelegate?
    
    @IBOutlet weak var infoButton: UIButton! {
        didSet {
            infoButton.setImage(UIImage(named: "info")?.withRenderingMode(.alwaysTemplate), for: .normal)
            infoButton.addTarget(self, action: #selector(handleInfoSelect), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var gridButton: UIButton! {
        didSet {
            gridButton.setImage(UIImage(named: "grid")?.withRenderingMode(.alwaysTemplate), for: .normal)
            gridButton.addTarget(self, action: #selector(handleGridLayoutSelect), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var listButton: UIButton! {
        didSet {
            listButton.setImage(UIImage(named: "list")?.withRenderingMode(.alwaysTemplate), for: .normal)
            listButton.addTarget(self, action: #selector(handleListLayoutSelect), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var masonryButton: UIButton! {
        didSet {
            masonryButton.setImage(UIImage(named: "masonry")?.withRenderingMode(.alwaysTemplate), for: .normal)
            masonryButton.addTarget(self, action: #selector(handleMasonryLayoutSelect), for: .touchUpInside)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    
        updateColorOnSelection(for: gridButton)
    }
    
    //MARK: Public methods
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
    
    //MARK: Button handlers

    @objc private func handleInfoSelect() {
        delegate?.didSelectInfo()
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

    //MARK: Private methods
    
    /**
     Function to change selected button color
     */
    private func updateColorOnSelection(for button: UIButton) {
        gridButton.tintColor = .lightGray
        listButton.tintColor = .lightGray
        masonryButton.tintColor = .lightGray

        button.tintColor = UIColor.appThemeColor
    }

}
