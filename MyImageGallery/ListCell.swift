//
//  ListCell.swift
//  MyImageGallery
//
//  Created by Abhirup on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {
    var picture: Picture? {
        didSet {
            pictureView.image = UIImage(named: "dog")
        }
    }
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 5
//            containerView.clipsToBounds = true
            
            containerView.layer.shadowColor = UIColor.lightGray.cgColor
            containerView.layer.shadowOpacity = 0.5
            containerView.layer.shadowOffset = CGSize.zero
            containerView.layer.shadowRadius = 4
            
//            containerView.layer.masksToBounds = true
            containerView.layer.shouldRasterize = true
        }
    }
    
    @IBOutlet weak var pictureView: UIImageView! {
        didSet {
            pictureView.contentMode = .scaleAspectFill
            pictureView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
            descriptionLabel.textColor = .darkGray
            descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            descriptionLabel.text = "This is a test description text."
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    private func setupViews() {
        //setup position of containerView (considering safeArea of device)
        containerView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 20, paddingBottom: 8, paddingRight: 20, width: 0, height: 0)
        
        
    }
    
}
