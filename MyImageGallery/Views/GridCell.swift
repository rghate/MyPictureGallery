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
                    //hide description container if description text is empty
                    descriptionBackgroundView.isHidden = true
                }
//                print("Description: \(descriptionLabel.text ?? "Nil") ** Count: \(description.count) *** \(descriptionBackgroundView.isHidden)")
            }
//            print("Original",  picture?.link ?? "")
            
            guard let link = picture?.link else { return }

            //download medium sized image thumbnail instead of full sized image
            //url for .gif are alredy modified to get thumbnail.. so skipping that.
//            if let type = picture?.type, type.contains("/gif") {
            
                guard let url = URL(string: link) else { return }
                
                self.pictureView.sd_setImage(with: url) { [weak self](_, err, _, _) in
                    if err != nil {
                        print("Failed for: ", url)
                    } else {
                        self?.pictureView.backgroundColor = .clear
                    }
                }
//            } else {
//                pictureView.setMediumImage(withUrlString: link)
//            }
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
            descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            descriptionLabel.textAlignment = .left
            //descriptionLabel.textColor = .darkGray
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        self.backgroundColor = .lightGray
    }
}
