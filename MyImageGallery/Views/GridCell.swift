//
//  GridCell.swift
//  MyImageGallery
//
//  Created by Abhirup on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class GridCell: UICollectionViewCell {
    
    var picture: Picture? {
        didSet {
            if let description = picture?.description {
                descriptionBackgroundView.isHidden = false
                
                if description.count > 0 {
                    descriptionLabel.text = picture?.description
                } else {
                    //hide description container view if description text is empty
                    descriptionBackgroundView.isHidden = true
                }
            }
            guard let link = picture?.link else { return }

            guard let url = URL(string: link) else { return }

            pictureView.loadImage(with: url)
        }
    }
    
    @IBOutlet weak var descriptionBackgroundView: UIVisualEffectView!
    
    @IBOutlet weak var pictureView: UIImageView! {
        didSet {
            pictureView.contentMode = .scaleAspectFill
            pictureView.backgroundColor = UIColor.rgb(red: 200, green: 200, blue: 200)
            pictureView.clipsToBounds = true
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 2
            descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            descriptionLabel.textAlignment = .left
            descriptionLabel.textColor = .black
            descriptionLabel.text = ""
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        self.backgroundColor = .lightGray
    }
}
