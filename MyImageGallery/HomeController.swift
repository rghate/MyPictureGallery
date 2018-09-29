//
//  HomeController.swift
//  MyImageGallery
//
//  Created by Abhirup on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CustomHeaderDelegate {
    
    private let gridCellId = "gridCellId"
    
    private let listCellId = "listCellId"

    private let headerId = "headerId"
    
    private let footerId = "footerId"
    
    private var isGridView = true
    
    private var headerView: CustomHeader?
    
    private var footerView: CustomFooter?
    
    private var pictures = [ Picture(imageUrl: "", description: "test - 1"),
                             Picture(imageUrl: "", description: "test - 2"),
                             Picture(imageUrl: "", description: "test - 3"),
                             Picture(imageUrl: "", description: "test - 4"),
                             Picture(imageUrl: "", description: "test - 5"),
                             Picture(imageUrl: "", description: "test - 6"),
                             Picture(imageUrl: "", description: "test - 7"),
                             Picture(imageUrl: "", description: "test - 8"),
                             Picture(imageUrl: "", description: "test - 9"),
                             Picture(imageUrl: "", description: "test - 10"),
                             Picture(imageUrl: "", description: "test - 11"),
                             Picture(imageUrl: "", description: "test - 12"),
                             Picture(imageUrl: "", description: "test - 13"),
                             Picture(imageUrl: "", description: "test - 14"),
                             Picture(imageUrl: "", description: "test - 15"),
                             Picture(imageUrl: "", description: "test - 16"),
                             Picture(imageUrl: "", description: "test - 17")
        
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        
        if pictures.count > 0 {
            collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        }
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        
        //register for grid cell
        let gridCellNib = UINib(nibName: "GridCell", bundle: nil)
        collectionView.register(gridCellNib, forCellWithReuseIdentifier: gridCellId)
        //register for list cell
        let listCellNib = UINib(nibName: "ListCell", bundle: nil)
        collectionView.register(listCellNib, forCellWithReuseIdentifier: listCellId)
        
        //register header cell
        let headerNib = UINib(nibName: "CustomHeader", bundle: nil)
        collectionView?.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        //register footer cell
        collectionView?.register(CustomFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
    }
    
    
    //MARK: collectionview header and footer view methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if pictures.count > 0 {
            //if pictures available, display collectionview header with appropriate height
            return CGSize(width: view.frame.width, height: 100)
        } else {
            //else hide collectionview header
            return CGSize(width: view.frame.width, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if pictures.count > 0 {
            //if pictures available, reduce footer height to zero to hide it
            return CGSize(width: view.frame.width, height: 0)
        } else {
            // if no pictures, display full screen footer to show either activity indicator or message for user
            return CGSize(width: view.frame.width, height: 300)
        }
    }
    
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
    
    
    //MARK: collectionview body methods
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isGridView {
            let width = (view.frame.width - 4) / 3  // to divide grid into 3 equal columns. 4 is inter-item spacing between columns(spacified in minimumInteritemSpacingForSectionAt delegate).
            return CGSize(width: width, height: width)
        } else {
            var height: CGFloat = view.frame.width + 8 + 8  // 4 + 4 is top and bottom spacing of contents of cell
            height -= height/3
            return CGSize(width: view.frame.width, height: height)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //for horizontal line spacing between rows
        return isGridView ? 2 : 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //for vertical line spacing between rows
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isGridView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gridCellId, for: indexPath) as! GridCell
            cell.picture = pictures[indexPath.item]
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCellId, for: indexPath) as! ListCell
            cell.picture = pictures[indexPath.item]
            
            return cell
        }
    }
    
    //MARK: CustomHeaderDelegate methods
    
    func didSelectGridLayout() {
        if !isGridView {
            isGridView = true
            collectionView.reloadData()
        }
    }

    func didSelectListLayout() {
        if isGridView {
            isGridView = false
            collectionView.reloadData()
        }
    }
    
    func didSelectMasonryLayout() {
    }
    
    
    //MARK: Device rotation callback
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
}
