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
    
  //  @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var pictureView: UIImageView! {
        didSet {
            pictureView.layer.cornerRadius = 8
            pictureView.layer.masksToBounds = true
        }
    }
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //    containerView.layer.cornerRadius = 8
        //    containerView.layer.masksToBounds = true
    }
    
    //  var photo: Photo? {
    //    didSet {
    //      if let photo = photo {
    //        imageView.image = photo.image
    //        commentLabel.text = photo.comment
    //      }
    //    }
    //  }
    
    var picture: Picture? {
        didSet {
            if let picture = picture, let imageView = pictureView {
                descriptionLabel.text = picture.description
                
                let url = URL(string: picture.link)
                
                imageView.sd_setImage(with: url) { (img, err, _, url) in
                    if err == nil { return }
                    
                    if let url = url {
                        print("Failed for \(img) of type :: \(picture.type)")
                        print("Failed to display url: \(url)")
                    }
                }
            }
        }
    }}
