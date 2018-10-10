//
//  HomeViewController+CollectionViewDelegateFlowLayout.swift
//  MyImageGallery
//
//  Created by RGhate on 09/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    //header view size
    func collectionView(collectionView: UICollectionView, sizeForSectionHeaderViewForSection section: Int) -> CGSize {
        if pictures.count > 0 {
            //if pictures available, display collectionview header with appropriate height
            return CGSize(width: view.frame.width, height: headerViewHeight)
        } else {
            //else hide collectionview header
            return CGSize(width: view.frame.width, height: 0)
        }
    }
    
    //footer view size
    func collectionView(collectionView: UICollectionView, sizeForSectionFooterViewForSection section: Int) -> CGSize {
        if pictures.count > 0 {
            //if pictures available, reduce footer height to zero to hide it
            return CGSize(width: view.frame.width, height: 0)
        } else {
            // if no pictures, display full screen footer to show either activity indicator or message for user
            return CGSize(width: view.frame.width, height: 300)
        }
    }
    
    //return view for header/footer
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CustomHeader
            
            self.headerView = header
            self.headerView?.delegate = self
            
            return header
            
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath) as! CustomFooter
            
            self.footerView = footer
            
            return footer
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if pictures.count == 0 {
            return UICollectionViewCell()
        }
        
        // if displayed all images available in pictures array, download more pictures from next page
        if indexPath.item == self.pictures.count - 1 && !isFinishedPaging {
            paginatePictures()
        }
        
        //return GridCell if current selected layout is grid
        if currentLayoutType ==  .grid {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gridCellId, for: indexPath) as! GridCell
            cell.picture = pictures[indexPath.item]
            
            return cell
        }
        //return ListCell if current selected layout is grid
        else if currentLayoutType ==  .list {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCellId, for: indexPath) as! ListCell
            cell.picture = pictures[indexPath.item]
            
            return cell
        } else {
            //return MasonryCell if current selected layout is grid
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: masonryCellId, for: indexPath) as! MasonryCell
            cell.picture = pictures[indexPath.item]
            
            return cell
        }
    }
    
}
