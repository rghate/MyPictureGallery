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
            if let picture = picture, let imageView = pictureView {
                
                if picture.description.count == 0 {
//                    descriptionBackgroundView.isHidden = true
                } else {
                    descriptionLabel.text = picture.description
                }
                
//                print(picture.description)
                
                let url = URL(string: picture.link)
                
                imageView.sd_setImage(with: url) { (img, err, _, url) in
                    if err == nil {
                        return
                    }
                    
                    if let url = url {
                        print("Failed for type :: \(picture.type ??  "" )")
                        print("Failed to display url: \(url)")
                    }
                }
            }
        }
    }
//    @IBOutlet weak var containerView: UIView! {
//        didSet {
//            containerView.layer.cornerRadius = 5
////            containerView.clipsToBounds = true
//
//            containerView.layer.shadowColor = UIColor.blue.cgColor
//            containerView.layer.shadowOpacity = 0.5
//            containerView.layer.shadowOffset = CGSize.zero
//            containerView.layer.shadowRadius = 4
//
////            containerView.layer.masksToBounds = true
//            containerView.layer.shouldRasterize = true
//        }
//    }
    
    @IBOutlet weak var pictureView: UIImageView! {
        didSet {
            pictureView.contentMode = .scaleAspectFit
            pictureView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 2
//            descriptionLabel.textColor = .darkGray
//            descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
//            descriptionLabel.text = "This is a test description text."
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    private func setupViews() {
        //setup position of containerView (considering safeArea of device)
//        containerView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 20, paddingBottom: 8, paddingRight: 20, width: 0, height: 0)
        
        
    }
    
}
