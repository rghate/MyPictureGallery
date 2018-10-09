//
//  CustomAlert.swift
//  MyImageGallery
//
//  Created by RGhate on 07/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class CustomAlert {
    
    func showAlert(withTitle title: String, message: String, viewController: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
