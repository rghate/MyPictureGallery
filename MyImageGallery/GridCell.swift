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
            pictureView.image = UIImage(named: "dog")
        }
    }
    
    @IBOutlet weak var pictureView: UIImageView! {
        didSet {
            pictureView.contentMode = .scaleAspectFill
//            pictureView.layer.cornerRadius = 10
//            pictureView.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
