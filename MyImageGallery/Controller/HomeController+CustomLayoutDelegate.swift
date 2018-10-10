//
//  HomeViewController+CustomLayoutDelegate.swift
//  MyImageGallery
//
//  Created by RGhate on 09/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

extension HomeViewController: CustomLayoutDelegate {
    
    //spacing between rows
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    //spacing between columns
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    
    //width for grid/list/masonry cell
    func collectionView(widthForItemIn collectionView: UICollectionView) -> CGFloat {
        //list cell width is same as collectionview width
        if currentLayoutType == .list {
            return collectionView.contentSize.width
        } else {
            //for grid and masonry layouts calculate cell width based on device size
            return getItemWidth()
        }
    }
    
    func collectionView(collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat {
        
        if currentLayoutType ==  .grid {
            return calculateGridItemHeight()
            
        } else if currentLayoutType ==  .list {
            return calculateListItemHeight()
            
        } else {
            let picture = pictures[indexPath.item]
            return calculateMasonryItemHeight(for: picture)
        }
    }
    
    private func calculateGridItemHeight() -> CGFloat {
        //height and width of cell are same for grid view layout
        let itemWidth = getItemWidth()
        let itemHeight = itemWidth
        return itemHeight
    }
    
    private func calculateListItemHeight() -> CGFloat {
        let imgHeightWithPadding: CGFloat = 8 + 300 //300 constant height of image in listview, 8 top padding
        let textContentHeight: CGFloat = 88 //constant height of stackview containing text labels
        let descriptionTextHeightWithPadding: CGFloat = textContentHeight + 12  //12 text padding
        
        let itemHeight = imgHeightWithPadding + descriptionTextHeightWithPadding + 8    //8 extra
        
        return itemHeight
    }
    
    private func calculateMasonryItemHeight(for picture: Picture) -> CGFloat {
        guard let imageWidth = picture.width else { return 0 }
        guard let imageHeight = picture.height else { return 0 }
        
        //calculate image height and width maintaining its aspect ratio
        let cellWidth = getItemWidth()
        let scale: CGFloat = cellWidth / CGFloat(imageWidth)
        let scaledImgHeight: CGFloat = CGFloat(imageHeight) * scale //scale up/down image height based on scale value of width to keep the aspect ratio of the image.
        
        var textContentHeightWithPadding: CGFloat = 0
        if picture.description.count > 0 {
            //to size the masonry cell accomodating image and text properly,
            //calculate runtime text height based on text-length, width of the cell and text font-size
            let textContentHeight = UILabel.height(for: picture.description, width: cellWidth, font: UIFont.systemFont(ofSize: 12))
            textContentHeightWithPadding = 10 + textContentHeight + 10  //10 label padding
        }
        let itemHeight = scaledImgHeight + textContentHeightWithPadding
        
        return itemHeight
    }
    
    /**
     Function to get approx width of the collectionView cell based on the device being used.
     Works properly with iPhone 6 and above
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

