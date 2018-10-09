//
//  CustomLayout.swift
//  MyImageGallery
//
//  Created by Abhirup on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit


/**
 CustomLayout
 */
public class CustomLayout: UICollectionViewLayout {
    
    /**
     Delegate.
     */
    public var delegate: CustomLayoutDelegate!
    /**
     Number of columns.
     */
    public var numberOfColumns: Int = 2
    /**
     Cell padding.
     */
    //  public var cellPadding: CGFloat = 4
    
    private var cache = [CustomLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        get {
            let bounds = collectionView.bounds
            let insets = collectionView.contentInset
            return bounds.width - insets.left - insets.right
        }
    }
    
    override public var collectionViewContentSize: CGSize {
        get {
            return CGSize(
                width: contentWidth,
                height: contentHeight
            )
        }
    }
    
    override public class var layoutAttributesClass: AnyClass {
        return CustomLayoutAttributes.self
    }
    
    override public var collectionView: UICollectionView {
        return super.collectionView!
    }
    
    private var numberOfSections: Int {
        return collectionView.numberOfSections
    }
    
    private func numberOfItems(inSection section: Int) -> Int {
        return collectionView.numberOfItems(inSection: section)
    }
    
    /**
     Invalidates layout.
     */
    override public func invalidateLayout() {
        cache.removeAll()
        contentHeight = 0
        
        super.invalidateLayout()
    }
    
    override public func prepare() {
        if cache.isEmpty {
            let itemWidth = delegate?.collectionView(widthForItemIn: collectionView)
            numberOfColumns = Int(contentWidth / itemWidth!)
            
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            
            var xOffsets = [CGFloat]()
            
            for collumn in 0..<numberOfColumns {
                xOffsets.append(CGFloat(collumn) * columnWidth)
            }
            
            for section in 0..<numberOfSections {
                let numberOfItems = self.numberOfItems(inSection: section)
                
                if let headerSize = delegate.collectionView?(
                    collectionView: collectionView,
                    sizeForSectionHeaderViewForSection: section
                    ) {
                    let headerX = (contentWidth - headerSize.width) / 2
                    let headerFrame = CGRect(
                        origin: CGPoint(
                            x: headerX,
                            y: contentHeight
                        ),
                        size: headerSize
                    )
                    let headerAttributes = CustomLayoutAttributes(
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                        with: IndexPath(item: 0, section: section)
                    )
                    headerAttributes.frame = headerFrame
                    cache.append(headerAttributes)
                    
                    contentHeight = headerFrame.maxY
                }
                
                var yOffsets = [CGFloat](
                    repeating: contentHeight,
                    count: numberOfColumns
                )
                
                for item in 0..<numberOfItems {
                    let indexPath = IndexPath(item: item, section: section)
                    
                    let column = yOffsets.index(of: yOffsets.min() ?? 0) ?? 0
                    
                    let columnSpacing = delegate.collectionView(collectionView: collectionView, layout: self, minimumInteritemSpacingForSectionAt: section)
                    
                    //          let cellWidth = collumnWidth - (columnSpacing * 2)
                    
                    let itemHeight = delegate.collectionView(collectionView: collectionView, heightForItemAt: indexPath)
                    
                    /*          let annotationHeight = delegate.collectionView(
                     collectionView: collectionView,
                     heightForAnnotationAtIndexPath: indexPath,
                     withWidth: cellWidth
                     )
                     */
                    let rowSpacing = delegate.collectionView(collectionView: collectionView, layout: self, minimumLineSpacingForSectionAt: section)
                    
                    let cellHeight = rowSpacing + itemHeight + /*annotationHeight +*/ rowSpacing
                    
                    let frame = CGRect(
                        x: xOffsets[column],
                        y: yOffsets[column],
                        width: columnWidth,
                        height: cellHeight
                    )
                    
                    let insetFrame = frame.insetBy(dx: columnSpacing, dy: rowSpacing)
                    let attributes = CustomLayoutAttributes(
                        forCellWith: indexPath
                    )
                    attributes.frame = insetFrame
                    attributes.cellContentHeight = itemHeight
                    cache.append(attributes)
                    
                    contentHeight = max(contentHeight, frame.maxY)
                    yOffsets[column] = yOffsets[column] + cellHeight
                }
                
                if let footerSize = delegate.collectionView?(
                    collectionView: collectionView,
                    sizeForSectionFooterViewForSection: section
                    ) {
                    let footerX = (contentWidth - footerSize.width) / 2
                    let footerFrame = CGRect(
                        origin: CGPoint(
                            x: footerX,
                            y: contentHeight
                        ),
                        size: footerSize
                    )
                    let footerAttributes = CustomLayoutAttributes(
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                        with: IndexPath(item: 0, section: section)
                    )
                    footerAttributes.frame = footerFrame
                    cache.append(footerAttributes)
                    
                    contentHeight = footerFrame.maxY
                }
            }
        }
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
    
    func clearCache() {
        cache.removeAll()
    }
}
