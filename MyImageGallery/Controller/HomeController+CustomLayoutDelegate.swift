//
//  HomeViewController+CustomLayoutDelegate.swift
//  MyImageGallery
//
//  Created by RGhate on 09/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

extension HomeViewController: CustomLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    func collectionView(widthForItemIn collectionView: UICollectionView) -> CGFloat {
        if currentLayoutType == .list {
            return collectionView.contentSize.width
        } else {
            return getItemWidth()
        }
    }
    
    func collectionView(collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat {
        let photo = pictures[indexPath.item]
        
        guard let imageWidth = photo.width else { return 0 }
        guard let imageHeight = photo.height else { return 0 }
        
        let cellWidth = getItemWidth()
        
        if currentLayoutType ==  .grid {
            //height and width of cell are same for grid view layout
            let cellHeight = cellWidth
            return cellHeight
        } else if currentLayoutType ==  .list {
            let imgHeightWithPadding: CGFloat = 8 + 300
            let textContentHeight: CGFloat = 88
            let descriptionTextHeightWithPadding: CGFloat = textContentHeight + 12
            
            let cellHeight = imgHeightWithPadding + descriptionTextHeightWithPadding + 8
            
            return cellHeight
        } else {
            let itemWidth = getItemWidth()
            
            let scale: CGFloat = itemWidth / CGFloat(imageWidth)
            let scaledImgHeight: CGFloat = CGFloat(imageHeight) * scale
            
            var textContentHeightWithPadding: CGFloat = 0
            if photo.description.count > 0 {
                let textContentHeight = UILabel.height(for: photo.description, width: itemWidth, font: UIFont.systemFont(ofSize: 12))
                textContentHeightWithPadding = 10 + textContentHeight + 10
            }
            let cellHeight = scaledImgHeight + textContentHeightWithPadding
            
            return cellHeight
        }
    }
    
    /**
        Function to get approx width of the collectionView cell based on the device being used
        works properly with iPhone 6 and above
     */
    private func getItemWidth() -> CGFloat {
        switch UIDevice().model.lowercased() {
        case "ipad":
            return 250
        default:
            return 170
        }
    }

}

