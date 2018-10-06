//
//  HomeController.swift
//  MyImageGallery
//
//  Created by Abhirup on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit
//import CHTCollectionViewWaterfallLayout

class HomeController: UICollectionViewController, CustomHeaderDelegate {
    
    private var currentLayoutType: Constants.LayoutType = .grid
    
    private let gridCellId = "gridCellId"
    
    private let listCellId = "listCellId"
    
    private let masonryCellId = "masonryCellId"
    
    private let headerId = "headerId"
    
    private let footerId = "footerId"
    
    private var headerView: CustomHeader?
    
    private var footerView: CustomFooter?
    
    private var pictures = [Picture]()
    
    private let contentInsets = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    
    fileprivate let interItemSpacing: CGFloat = 6
    
    fileprivate let lineSpacing: CGFloat = 6
    
    private var currentBarButtonItem: UIBarButtonItem?
    private var gridBarButtonItem = UIBarButtonItem()
    private var listBarButtonItem = UIBarButtonItem()
    private var masonryBarButtonItem = UIBarButtonItem()
    private var barButtonItems = [UIBarButtonItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        print (UIDevice().localizedModel)
        
        setupNavigationBar()
        
        setupCollectionView()
        
        fetchAndLoadPictures()
        
        setupRefreshControl()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.tintColor = .lightGray
        
        gridBarButtonItem = UIBarButtonItem(image: UIImage(named: "grid_nav_item"), style: .plain, target: self, action: #selector(handleLayoutChangeToGrid))
        listBarButtonItem = UIBarButtonItem(image: UIImage(named: "list_nav_item"), style: .plain, target: self, action: #selector(handleLayoutChangeToList))
        masonryBarButtonItem = UIBarButtonItem(image: UIImage(named: "masonry_nav_item"), style: .plain, target: self, action: #selector(handleLayoutChangeToMasonry))
        
        barButtonItems = [masonryBarButtonItem, listBarButtonItem, gridBarButtonItem]
        
        currentBarButtonItem = gridBarButtonItem
    }
    
    @objc private func handleLayoutChangeToGrid() {
        handleLayoutChange(to: .grid)
    }
    
    @objc private func handleLayoutChangeToList() {
        handleLayoutChange(to: .list)
    }
    
    @objc private func handleLayoutChangeToMasonry() {
        handleLayoutChange(to: .masonry)
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        
        let layout = collectionView.collectionViewLayout as? PinterestLayout
        
        layout?.delegate = self
        
        collectionView?.contentInset = contentInsets
        
        collectionView.backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245)
        
        if pictures.count > 0 {
            collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        }
        
        //register for grid cell
        let gridCellNib = UINib(nibName: "GridCell", bundle: nil)
        collectionView.register(gridCellNib, forCellWithReuseIdentifier: gridCellId)
        //register for list cell
        let listCellNib = UINib(nibName: "ListCell", bundle: nil)
        collectionView.register(listCellNib, forCellWithReuseIdentifier: listCellId)
        
        let masonryCellNib = UINib(nibName: "MasonryCell", bundle: nil)
        collectionView.register(masonryCellNib, forCellWithReuseIdentifier: masonryCellId)
        
        //register header cell
        let headerNib = UINib(nibName: "CustomHeader", bundle: nil)
        collectionView?.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        //register footer cell
        collectionView?.register(CustomFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func fetchAndLoadPictures() {
        APIService.shared.fetch { [weak self] (err, pictures) in
            guard let self = self else { return }
            
            self.pictures.removeAll()
            
            self.collectionView.refreshControl?.endRefreshing()
            if let err = err {
                self.collectionView.reloadData()
                CustomAlert().showAlert(withTitle: "Error", message: err.localizedDescription, viewController: self)
                self.footerView?.setMessage(withText: "Something is wrong 😢.\n\n Drag down to try again.", visibleWaitIndicator:  false)
                return
            }
//            self.pictures.removeAll()
            self.pictures = pictures

            self.handleLayoutChange(to: self.currentLayoutType)
        }
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
    }
    
    @objc private func handleRefresh() {
        self.footerView?.resetMessage(visibleWaitIndicator: false)
        fetchAndLoadPictures()
    }
    
    //MARK: collectionview header and footer view methods
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.y
        
        if scrollPos > -40.0 {
            if navigationItem.rightBarButtonItems?.count == 0 || navigationItem.rightBarButtonItems?.count == nil {
                navigationItem.rightBarButtonItems = barButtonItems
            }
        } else {
            if navigationItem.rightBarButtonItems?.count ?? 0 > 0 {
                navigationItem.rightBarButtonItems?.removeAll()
            }
        }
    }
    
    //MARK: Device rotation callback
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        reloadCollectionView()
    }
    
    
    //MARK: CustomHeaderDelegate methods
    
    func didSelectGridLayout() {
        if currentLayoutType != .grid {
            handleLayoutChange(to: .grid)
        }
    }
    
    func didSelectListLayout() {
        if currentLayoutType != .list {
            handleLayoutChange(to: .list)
        }
    }
    
    func didSelectMasonryLayout() {
        if currentLayoutType != .masonry {
            handleLayoutChange(to: .masonry)
        }
    }
    
    private func handleLayoutChange(to layoutType: Constants.LayoutType) {
        currentBarButtonItem?.tintColor = .lightGray
        
        let barButtonItem: UIBarButtonItem?
        switch layoutType {
        case .grid:
            barButtonItem = gridBarButtonItem
            break
        case .list:
            barButtonItem = listBarButtonItem
            break
        case .masonry:
            barButtonItem = masonryBarButtonItem
            break
        }
        currentBarButtonItem = barButtonItem
        currentBarButtonItem?.tintColor = UIColor.appThemeColor

        currentLayoutType = layoutType

        //update image color of collectionView header
        headerView?.layoutChanged(to: layoutType)

        reloadCollectionView()
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, sizeForSectionHeaderViewForSection section: Int) -> CGSize {
        if pictures.count > 0 {
            //if pictures available, display collectionview header with appropriate height
            return CGSize(width: view.frame.width, height: 60)
        } else {
            //else hide collectionview header
            return CGSize(width: view.frame.width, height: 0)
        }
    }
    
    func collectionView(collectionView: UICollectionView, sizeForSectionFooterViewForSection section: Int) -> CGSize {
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    private func getItemWidth() -> CGFloat {
        switch UIDevice().model.lowercased() {
        case "ipad":
            return 250
        default:
            return 170
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if pictures.count == 0 {
            return UICollectionViewCell()
        }
        
        if currentLayoutType ==  .grid {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gridCellId, for: indexPath) as! GridCell
            cell.picture = pictures[indexPath.item]
            
            return cell
        }
        else if currentLayoutType ==  .list {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCellId, for: indexPath) as! ListCell
            cell.picture = pictures[indexPath.item]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: masonryCellId, for: indexPath) as! MasonryCell
            cell.picture = pictures[indexPath.item]
            
            return cell
        }
    }
    
}

extension HomeController: PinterestLayoutDelegate {
    
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
//            let textContentHeight: CGFloat = 100
            let cellHeight = cellWidth /*+ textContentHeight */
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
//            let descriptionTextHeight: CGFloat = (photo.description.count > 0) ? 100 : 0
            
            var textContentHeightWithPadding: CGFloat = 0
            if photo.description.count > 0 {
                let textContentHeight = UILabel.height(for: photo.description, width: itemWidth, font: UIFont.systemFont(ofSize: 12))
                textContentHeightWithPadding = 10 + textContentHeight + 10
            }
            let cellHeight = scaledImgHeight + textContentHeightWithPadding

            return cellHeight
        }
    }
}

