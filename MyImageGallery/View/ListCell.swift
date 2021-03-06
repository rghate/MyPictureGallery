//
//  ListCell.swift
//  MyImageGallery
//
//  Created by RGhate on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {
    
    //MARK: Public properties
    
    var picture: Picture? {
        didSet {
            numberOfViewsLabel.text = "\(picture?.views.decimalFormat() ?? "0") views" //UInt extension method
            descriptionLabel.text = picture?.description

            let uploadDate = picture?.uploadDate ?? Date()
            durationLabel.text = uploadDate.timeAgoDisplay().uppercased()   //Date extension method

            guard let link = picture?.link else { return }
            
            guard let url = URL(string: link) else { return }

            pictureView.loadImage(with: url)   //loadImage is an UIImageView extension method
        }
    }
    
    @IBOutlet weak var pictureView: UIImageView! {
        didSet {
            pictureView.contentMode = .scaleAspectFit
            pictureView.layer.masksToBounds = true
            //default color before image loading
            pictureView.backgroundColor = .placeholderBackgroundColor
        }
    }
    
    @IBOutlet weak var numberOfViewsLabel: UILabel! {
        didSet {
            numberOfViewsLabel.font = UIFont.boldSystemFont(ofSize: 16)
            numberOfViewsLabel.textAlignment = .left
            numberOfViewsLabel.textColor = .darkText
            numberOfViewsLabel.text = ""
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 2
            descriptionLabel.font = UIFont.systemFont(ofSize: 16)
            descriptionLabel.textAlignment = .left
            descriptionLabel.textColor = .darkText
            descriptionLabel.text = ""
        }
    }

    @IBOutlet weak var durationLabel: UILabel! {
        didSet {
            durationLabel.font = UIFont.systemFont(ofSize: 12)
            durationLabel.textAlignment = .left
            durationLabel.textColor = .darkGray
            durationLabel.text = ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
    }

}
