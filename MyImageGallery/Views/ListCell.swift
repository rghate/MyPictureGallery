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
            descriptionLabel.text = picture?.description
            
            guard let link = picture?.link else { return }
            
            guard let url = URL(string: link) else { return }
            
            self.pictureView.sd_setImage(with: url) {[weak self] (_, err, _, _) in
                if err != nil {
                    print("Failed for: ", url)
                } else {
                    self?.pictureView.backgroundColor = .clear
                }
            }
        }
    }
    
    @IBOutlet weak var pictureView: UIImageView! {
        didSet {
            pictureView.contentMode = .scaleAspectFit
            pictureView.clipsToBounds = true
            pictureView.backgroundColor = .lightGray
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 2
            descriptionLabel.font = UIFont.systemFont(ofSize: 16)
            descriptionLabel.textAlignment = .left
            descriptionLabel.textColor = .black
            descriptionLabel.text = ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
