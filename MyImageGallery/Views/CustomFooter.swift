//
//  CustomFooter.swift
//  MyImageGallery
//
//  Created by Abhirup on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class CustomFooter: UICollectionViewCell {

    private let waitIndicator: UIActivityIndicatorView = {
       let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.hidesWhenStopped = false
        indicatorView.style = .whiteLarge
        indicatorView.color = .gray
        return indicatorView
    }()
    
    private let messageLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    //MARK: Public method(s)
    func setMessage(withText text: String, visibleWaitIndicator: Bool) {
        messageLabel.text = text
        
        if visibleWaitIndicator {
            waitIndicator.startAnimating()
        } else {
            waitIndicator.stopAnimating()
        }
        waitIndicator.isHidden = !visibleWaitIndicator
    }

    func resetMessage(visibleWaitIndicator: Bool) {
        messageLabel.text = ""
        
        if visibleWaitIndicator {
            waitIndicator.startAnimating()
        } else {
            waitIndicator.stopAnimating()
        }
        waitIndicator.isHidden = !visibleWaitIndicator
    }


    //MARK: Private method(s)

    private func setupViews() {
        addSubview(messageLabel)
        messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        addSubview(waitIndicator)
        waitIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        waitIndicator.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
