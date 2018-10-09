//
//  AboutViewController.swift
//  MyImageGallery
//
//  Created by Abhirup on 08/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView! {
        didSet {
            logoImageView.image = UIImage(named: "logo")?.withRenderingMode(.alwaysTemplate)
            logoImageView.tintColor = .appThemeColor
        }
    }
    
    @IBOutlet weak var appTitleLabel: UILabel! {
        didSet {
            appTitleLabel.font = UIFont.boldSystemFont(ofSize: 22)
            appTitleLabel.textAlignment = .center
            appTitleLabel.textColor = .darkText
        }
    }
    @IBOutlet weak var dividerLineView: UIView! {
        didSet {
            dividerLineView.backgroundColor = .appThemeColor
        }
    }
    
    @IBOutlet weak var buildTimeLabel: UILabel! {
        didSet {
            buildTimeLabel.text = "Build Time".uppercased()
            buildTimeLabel.textColor = .gray
            buildTimeLabel.font = UIFont.systemFont(ofSize: 12)
            buildTimeLabel.textAlignment = .center
        }
    }
    
    @IBOutlet weak var buildTimeValueLabel: UILabel! {
        didSet {
            buildTimeValueLabel.text = "-"
            buildTimeValueLabel.textColor = .darkText
            buildTimeValueLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            buildTimeValueLabel.textAlignment = .center
        }
    }
    
    @IBOutlet weak var authorLabel: UILabel! {
        didSet {
            authorLabel.text = "Author".uppercased()
            authorLabel.textColor = .gray
            authorLabel.font = UIFont.systemFont(ofSize: 12)
            authorLabel.textAlignment = .center
        }
    }
    
    @IBOutlet weak var authorValueLabel: UILabel! {
        didSet {
            authorValueLabel.text = "-"
            authorValueLabel.textColor = .darkText
            authorValueLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            authorValueLabel.textAlignment = .center
        }
    }
    

    @IBOutlet weak var versionValueLabel: UILabel! {
        didSet {
            versionValueLabel.text = ""
            versionValueLabel.textColor = .darkGray
            versionValueLabel.font = UIFont.systemFont(ofSize: 14)
            versionValueLabel.textAlignment = .center
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "About"
        
        setupNavigationBar()
        
        //App display name
        appTitleLabel.text = getApplicationDisplayName()
        
        //App author name
        let userName = NSFullUserName()
        authorValueLabel.text = userName.isEmpty ? "-" : userName
        
        //App build date and time
        let buildTime = getBuildTime()
        buildTimeValueLabel.text = buildTime

        //App version number
        if let version = getAppVersionNumber() {
            versionValueLabel.text = "\("Version".uppercased()) \(version)"
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getApplicationDisplayName() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    private func getAppVersionNumber() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    private func getBuildTime() -> String {
        return "\(compileDate() ?? ""), \(compileTime() ?? "")"
    }
    
}
