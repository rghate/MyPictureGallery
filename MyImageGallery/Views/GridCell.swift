//
//  GridCell.swift
//  MyImageGallery
//
//  Created by RGhate on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class GridCell: UICollectionViewCell {
    
    //MARK: Public properties
    var picture: Picture? {
        didSet {
            //reset descriptionBackgroundView visibility
            descriptionBackgroundView.isHidden = false

            if let description = picture?.description {
                if description.count > 0 {
                    descriptionLabel.text = picture?.description
                } else {
                    //hide description container view if description text is empty
                    descriptionBackgroundView.isHidden = true
                }
            }
            guard let link = picture?.link else { return }

            guard let url = URL(string: link) else { return }
            
            pictureView.loadImage(with: url)    //loadImage is an UIImageView extension method
        }
    }
    
    @IBOutlet weak var descriptionBackgroundView: UIVisualEffectView!   //containts description labelView
    
    @IBOutlet weak var pictureView: UIImageView! {
        didSet {
            pictureView.contentMode = .scaleAspectFill
            pictureView.clipsToBounds = true
            pictureView.backgroundColor = .placeholderBackgroundColor //default color before image loading
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 2
            descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            descriptionLabel.textAlignment = .left
            descriptionLabel.textColor = .darkText
            descriptionLabel.text = ""
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.backgroundColor = .placeholderBackgroundColor
    }
}
