//
//  MasonryLayoutDelegate.swift
//  MyImageGallery
//
//  Created by Abhirup on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit


/**
 PinterestLayoutDelegate.
 */
@objc public protocol PinterestLayoutDelegate {
    /**
     Size for section header. Optional.
     
     @param collectionView - collectionView
     @param section - section for section header view
     
     Returns size for section header view.
     */
    @objc optional func collectionView(collectionView: UICollectionView,
                                       sizeForSectionHeaderViewForSection section: Int) -> CGSize
    /**
     Size for section footer. Optional.
     
     @param collectionView - collectionView
     @param section - section for section footer view
     
     Returns size for section footer view.
     */
    @objc optional func collectionView(collectionView: UICollectionView,
                                       sizeForSectionFooterViewForSection section: Int) -> CGSize
    
    /**
     Width for content of cell.
     
     @param collectionView - collectionView
     @param indexPath - index path for cell
     
     Returns width of contents of cell.
     */
    func collectionView(widthForItemIn collectionView: UICollectionView) -> CGFloat
    
    
    /**
     Height for content of cell.
     
     @param collectionView - collectionView
     @param indexPath - index path for cell
     
     Returns height of contents of cell.
     */
    func collectionView(collectionView: UICollectionView,
                        heightForItemAt indexPath: IndexPath) -> CGFloat
    
    /**
     Height for annotation view in cell.
     
     @param collectionView - collectionView
     @param indexPath - index path for cell
     
     Returns height of annotation view.
     
     func collectionView(collectionView: UICollectionView,
     heightForAnnotationAtIndexPath indexPath: IndexPath,
     withWidth: CGFloat) -> CGFloat
     */
    
    /**
     Spacing between the rows of collectionView.
     
     @param collectionView - collectionView
     @param layout - layout of collectionView
     @param section - section of the row
     
     Returns spacing between the rows
     */
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    
    /**
     Spacing between the columns of collectionView.
     
     @param collectionView - collectionView
     @param layout - layout of collectionView
     @param section - section of the column
     
     Returns spacing between the columns
     */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    
}
