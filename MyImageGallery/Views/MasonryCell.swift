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
    
    var picture: Picture? {
        didSet {
            if let url = URL(string: picture?.link ?? "")  {
                pictureImageView.sd_setImage(with: url) { [weak self] (image, error, _ , _) in
                    guard let strongSelf = self else { return }
                    if error != nil {
                        strongSelf.pictureImageView.backgroundColor = UIColor.lightGray
                        return
                    }
                }
            }
            descriptionLabel.text = picture?.description
        }
    }
    
    lazy var pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        
        
        setupViews()
    }
    
    var heightAnchorConstraint: NSLayoutConstraint?
    var widthAnchorConstraint = NSLayoutConstraint()
    
    private func setupViews() {
        addSubview(pictureImageView)
        pictureImageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        pictureImageView.heightAnchor.constraint(equalTo: pictureImageView.widthAnchor).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: pictureImageView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
