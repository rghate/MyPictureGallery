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
            if let picture = picture {

                print(picture.description)
//                if picture.description.count == 0 {
//                    descriptionBackgroundView.isHidden = true
//                } else {
                    descriptionLabel.text = picture.description
//                }

            let url = URL(string: picture.link)

                pictureView?.sd_setImage(with: url) { (img, err, _, url) in
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
