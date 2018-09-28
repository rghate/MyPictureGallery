//
//  CustomHeader.swift
//  MyImageGallery
//
//  Created by Abhirup on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class CustomHeader: UICollectionViewCell {

    @IBOutlet weak var gridButton: UIButton!
    
    @IBOutlet weak var listButton: UIButton!
    
    @IBOutlet weak var masonryButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gridButton.tintColor = .red
        listButton.tintColor = .lightGray
        masonryButton.tintColor = .lightGray
    }

}
