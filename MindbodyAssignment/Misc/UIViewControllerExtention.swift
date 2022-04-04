//
//  UIViewControllerExtention.swift
//  MindbodyAssignment
//
//  Created by MeTaLlOiD on 04/04/22.
//

import UIKit

let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

// UIViewController is extended by some commonly used features. This will make them available to every UIViewController Subclass
extension UIViewController {
    
// MARK: - Activity Indicator Methods
    func startActivityIndicatorAnimation() {
        activityIndicator.bounds = view.bounds
        activityIndicator.center = view.center
        activityIndicator.backgroundColor = UIColor(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func stopActivityIndicatorAnimation() {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
        
    }
    
// MARK: - Alert Controller Methods
    func showReloadableAlert(title: String, message: String, reloadAction: @escaping (UIAlertAction)->Void) {
        let alertController = UIAlertController()
        alertController.title = title
        alertController.message = message
        alertController.addAction(UIAlertAction(title: "Reload", style: UIAlertAction.Style.default, handler: reloadAction))
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController()
        alertController.title = title
        alertController.message = message
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}


