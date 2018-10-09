//
//  MasonryCell.swift
//  MyImageGallery
//
//  Created by Abhirup on 04/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class MasonryCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var pictureView: UIImageView! {
        didSet {
            pictureView.layer.cornerRadius = 8
            pictureView.layer.masksToBounds = true
        }
    }
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!

    var picture: Picture? {
        didSet {
            descriptionLabel.text = picture?.description
            
            guard let link = picture?.link else { return }
            
            guard let url = URL(string: link) else { return }
            
            pictureView.loadImage(with: url)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
