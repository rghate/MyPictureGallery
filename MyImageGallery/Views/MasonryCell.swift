//
//  MasonryCell.swift
//  MyImageGallery
//
//  Created by Abhirup on 04/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit
import SDWebImage

class MasonryCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var pictureView: UIImageView! {
        didSet {
            pictureView.layer.cornerRadius = 8
            pictureView.layer.masksToBounds = true
        }
    }
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var picture: Picture? {
        didSet {
            descriptionLabel.text = picture?.description
            
            guard let link = picture?.link else { return }
            
            //download medium sized image thumbnail instead of full sized image
            //url for .gif are alredy modified to get thumbnail.. so skipping that.
            if let type = picture?.type, type.contains("/gif") {

                guard let url = URL(string: link) else { return }

                self.pictureView.sd_setImage(with: url) { [weak self] (_, err, _, _) in
                    if err != nil {
                        print("Failed for: ", url)
                    }
                    else {
                        self?.pictureView.backgroundColor = .clear
                    }
                }
            } else {
                pictureView.setMediumImage(withUrlString: link)
            }
        }
    }}
