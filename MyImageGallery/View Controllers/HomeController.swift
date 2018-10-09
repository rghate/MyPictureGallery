//
//  HomeController.swift
//  MyImageGallery
//
//  Created by RGhate on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {
    //internal variables
    internal let gridCellId = "gridCellId"
    internal let listCellId = "listCellId"
    internal let masonryCellId = "masonryCellId"
    internal let headerId = "headerId"
    internal let footerId = "footerId"
    internal var headerView: CustomHeader?
    internal var footerView: CustomFooter?
    internal let interItemSpacing: CGFloat = 6
    internal let lineSpacing: CGFloat = 6
    internal var pictures = [Picture]()
    internal var isFinishedPaging: Bool = false
    internal var currentLayoutType: Constants.LayoutType = .grid

    //private variables
    //right bar button item
    private var infoBarButtonItem = UIBarButtonItem()
    private var rightBarButtonItems = [UIBarButtonItem]()
    //left bar button items
    private var gridBarButtonItem = UIBarButtonItem()
    private var listBarButtonItem = UIBarButtonItem()
    private var masonryBarButtonItem = UIBarButtonItem()
    private var leftBarButtonItems = [UIBarButtonItem]()
    private var selectedLeftBarButtonItem: UIBarButtonItem?
    private let contentInsets = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    private var currentImageCategory: Constants.ImageCategory = .top
    private var currentPageNumber = -1
    private var isViral: Bool = true

    private var menuFloatingButton = FloatingButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"

        setupViews()
        setupRefreshControl()
        fetchAndLoadPictures()
    }

    private func setupViews() {
        setupNavigationBar()
        
        setupCollectionView()
        
        setupMenuButtons()
    }
    
    //MARK: navigationbar methods
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.tintColor = .lightGray

        //right bar button item
        infoBarButtonItem = UIBarButtonItem(image: UIImage(named: "info"), style: .plain, target: self, action: #selector(handleInfo))
        infoBarButtonItem.tintColor = .black
        
        //left bar button items
        gridBarButtonItem = UIBarButtonItem(image: UIImage(named: "grid_nav_item"), style: .plain, target: self, action: #selector(handleLayoutChangeToGrid))
        listBarButtonItem = UIBarButtonItem(image: UIImage(named: "list_nav_item"), style: .plain, target: self, action: #selector(handleLayoutChangeToList))
        masonryBarButtonItem = UIBarButtonItem(image: UIImage(named: "masonry_nav_item"), style: .plain, target: self, action: #selector(handleLayoutChangeToMasonry))
        leftBarButtonItems = [gridBarButtonItem, listBarButtonItem, masonryBarButtonItem]

        selectedLeftBarButtonItem = gridBarButtonItem
        selectedLeftBarButtonItem?.tintColor = .appThemeColor
    }
    
    //MARK: navigationbar handlers
    /**
     Function to launch AboutViewController
     */
    @objc private func handleInfo() {
        let aboutViewController = AboutViewController()
        let navController = UINavigationController(rootViewController: aboutViewController)
        self.present(navController, animated: true, completion: nil)
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

    /** Function to update variables related with collectionView layout change.
     Updates navigationBar button color as per layout type
     Reloads collection view to for the selected layout
     */
    private func handleLayoutChange(to layoutType: Constants.LayoutType) {
        selectedLeftBarButtonItem?.tintColor = .lightGray
        
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
        selectedLeftBarButtonItem = barButtonItem
        //highligh respective navigationbutton color of the selected layout type
        selectedLeftBarButtonItem?.tintColor = UIColor.appThemeColor
        
        currentLayoutType = layoutType
        //update image color of collectionView header
        headerView?.layoutChanged(to: layoutType)
        
        reloadCollectionView()
    }

    //MARK: collectionView methods
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        
        //Same CutomLayout is used for all three layout (grid/list/masonry) types.
        let layout = collectionView.collectionViewLayout as? CustomLayout
        layout?.delegate = self
        
        collectionView?.contentInset = contentInsets
//        collectionView.backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245)
        
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
        //register for grid cell
        let gridCellNib = UINib(nibName: "GridCell", bundle: nil)
        collectionView.register(gridCellNib, forCellWithReuseIdentifier: gridCellId)
        //register for list cell
        let listCellNib = UINib(nibName: "ListCell", bundle: nil)
        collectionView.register(listCellNib, forCellWithReuseIdentifier: listCellId)
        //register for masonry cell
        let masonryCellNib = UINib(nibName: "MasonryCell", bundle: nil)
        collectionView.register(masonryCellNib, forCellWithReuseIdentifier: masonryCellId)
        
        //register header cell
        let headerNib = UINib(nibName: "CustomHeader", bundle: nil)
        collectionView?.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        //register footer cell
        collectionView?.register(CustomFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
    }
    
    
    //MARK: FloatingMenu methods and handlers

    /** Function to add and place a floating menu-button in view
        (menuButton is used for displaying custom menu for selection of image categofy (hot/top/viral))
     */
    private func setupMenuButtons() {
        let buttonHeightWidth: CGFloat = 70
        //add (toggle) menuFloatingButton for displaying custom menu
        menuFloatingButton.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.view.addSubview(menuFloatingButton)

        //place menuButton at the bottom-left corner of the view
        menuFloatingButton.anchor(top: nil, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 0, width: buttonHeightWidth, height: buttonHeightWidth)

        menuFloatingButton.layer.cornerRadius = buttonHeightWidth/2
        menuFloatingButton.addTarget(self, action: #selector(handleMenu), for: .touchUpInside)
    }
    
    @objc private func handleMenu() {
        openFloatingMenu()
    }

    private func openFloatingMenu() {
        let floatingMenu = FloatingMenu()
        floatingMenu.imageCategory = currentImageCategory
        floatingMenu.isViral = isViral
        
        let mainWindow = UIApplication.shared.keyWindow!
        //add floatingMenu in application's main window instead of own view to display it in full screen(including status and navigation bar!).
        mainWindow.addSubview(floatingMenu)
        
        //setup annchor constraints of floating menu w.r.t. app's main window anchor constraints
        floatingMenu.anchor(top: mainWindow.topAnchor, left: mainWindow.leftAnchor, bottom: mainWindow.bottomAnchor, right: mainWindow.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        floatingMenu.delegate = self
    }
    
    //MARK: Refresh control methods and handlers
    /**
        Function to setup refresh control on collectionView
     */
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
    }
    
    /**
     download pictures to reload collectionView will latest images
     */
    @objc private func handleRefresh() {
        fetchAndLoadPictures()
        self.footerView?.setMessage(withText: "Please wait", visibleWaitIndicator: false)
    }

    internal func fetchAndLoadPictures() {
        if currentPageNumber == -1 {
            prepareBeforeDataDownload()
        } else {
            //show wait indicator
            footerView?.setMessage(withText: "Please wait", visibleWaitIndicator: true)
        }
        currentPageNumber += 1
        APIServiceManager.shared.getPictures(forCategory: currentImageCategory, showViralImages: isViral,pageNumber: currentPageNumber) { [weak self] (err, pictures) in
            guard let self = self else { return }
            
            //self.pictures.removeAll()
            
            self.collectionView.refreshControl?.endRefreshing()
            if let err = err {
                self.collectionView.reloadData()
                CustomAlert().showAlert(withTitle: "Error", message: err.localizedDescription, viewController: self)
                self.footerView?.setMessage(withText: "Something is wrong 😢.\n\n Drag down to try again.", visibleWaitIndicator:  false)
                return
            }
            if pictures.count > 0 {
                pictures.forEach({ (picture) in
                    self.pictures.append(picture)
                })
            } else {
                self.isFinishedPaging = true
            }
            self.prepareAfterDataDownload()
        }
    }

    private func prepareBeforeDataDownload() {
        menuFloatingButton.isHidden = true
        //show wait indicator
        footerView?.setMessage(withText: "Please wait", visibleWaitIndicator: true)
        
        isFinishedPaging = false
        currentPageNumber = -1
        
        pictures.removeAll()
        reloadCollectionView()
    }
    
    private func prepareAfterDataDownload() {
        menuFloatingButton.isHidden = false
        //show wait indicator
        footerView?.resetMessage(visibleWaitIndicator: false)
        
        if !isFinishedPaging {
            reloadCollectionView()
        }
    }

    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    //MARK: scrollview methdod to add/remove navigationbar button items.
    /** When scrolling up - if scroll position goes above -40, show rightbar info button and leftbar items(grid, list and masonry).
     When scrollign down - remove barbutton items
     */
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.y
        
        if scrollPos > -40.0 {
            if navigationItem.leftBarButtonItems?.count == 0 || navigationItem.leftBarButtonItems?.count == nil {
                navigationItem.leftBarButtonItems = leftBarButtonItems
                navigationItem.rightBarButtonItem = infoBarButtonItem
            }
        } else {
            if navigationItem.leftBarButtonItems?.count ?? 0 > 0 {
                navigationItem.leftBarButtonItems?.removeAll()
                navigationItem.rightBarButtonItem = nil
            }
        }
    }
    
    //MARK: Device rotation callback
    /** reload collection view on device rotation */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        reloadCollectionView()
    }
}

//MARK: extension to handle FloatingMenuDelegate methods

extension HomeController: FloatingMenuDelegate {
    
    func didSelectPictureCategory(with category: Constants.ImageCategory) {
        if category == .hot {
            currentImageCategory = .hot
        } else {
            currentImageCategory = .top
        }
        currentPageNumber = -1
        fetchAndLoadPictures()
    }
    
    func didSelectViral() {
        isViral = true
        currentPageNumber = -1
        fetchAndLoadPictures()
    }
    
    func didDeselectViral() {
        isViral = false
        currentPageNumber = -1
        fetchAndLoadPictures()
    }
}


//MARK: extension to handle CustomHeaderDelegate methods

extension HomeController: CustomHeaderDelegate{
    //MARK: CustomHeaderDelegate methods
    
    func didSelectInfo() {
        handleInfo()
    }
    
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

}
