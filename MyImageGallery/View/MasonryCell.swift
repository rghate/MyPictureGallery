//
//  MasonryCell.swift
//  MyImageGallery
//
//  Created by RGhate on 04/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class MasonryCell: UICollectionViewCell {
    
    //MARK: Public properties
    
    var picture: Picture? {
        didSet {
            descriptionLabel.text = picture?.description
            
            guard let link = picture?.link else { return }
            
            guard let url = URL(string: link) else { return }
            
            pictureView.loadImage(with: url)    //loadImage is an UIImageView extension method
        }
    }

    @IBOutlet fileprivate weak var pictureView: UIImageView! {
        didSet {
            pictureView.layer.cornerRadius = 8
            pictureView.layer.masksToBounds = true
            pictureView.contentMode = .scaleAspectFill
            //default color before image loading
            pictureView.backgroundColor = .placeholderBackgroundColor
        }
    }

    @IBOutlet fileprivate weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = ""
            descriptionLabel.numberOfLines = 0
            descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            descriptionLabel.textAlignment = .left
            descriptionLabel.textColor = .darkText
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .placeholderBackgroundColor
    }

}
