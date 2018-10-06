//
//  CustomFooter.swift
//  MyImageGallery
//
//  Created by Abhirup on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class CustomFooter: UICollectionViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//    }
    
    private let waitIndicator: UIActivityIndicatorView = {
       let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.hidesWhenStopped = true
        indicatorView.style = .whiteLarge
        indicatorView.color = .gray
        indicatorView.startAnimating()
        return indicatorView
    }()
    
    private let messageLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "test message"
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
    func setMessage(with text: String, waitIndicationToBeShown: Bool) {
        messageLabel.text = text
        
        if waitIndicationToBeShown == true {
            waitIndicator.startAnimating()
        } else {
            waitIndicator.stopAnimating()
        }
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
