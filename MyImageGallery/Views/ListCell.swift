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
            
            //download medium sized image thumbnail instead of full sized image
            //url for .gif are alredy modified to get thumbnail.. so skipping that.
            if let type = picture?.type, type.contains("/gif") {

                guard let url = URL(string: link) else { return }

                self.pictureView.sd_setImage(with: url) {[weak self] (_, err, _, _) in
                    if err != nil {
                        print("Failed for: ", url)
                    } else {
                        self?.pictureView.backgroundColor = .clear
                    }
                }
            } else {
                pictureView.setMediumImage(withUrlString: link)
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
            //            descriptionLabel.textColor = .darkGray
            //            descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            //            descriptionLabel.text = ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    private func setupViews() {
        //setup position of containerView (considering safeArea of device)
        //        containerView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 20, paddingBottom: 8, paddingRight: 20, width: 0, height: 0)
        
        
    }
    
}
