//
//  UIViewController+Ext.swift
//  Assessment
//
//  Created by Arvin Quiliza on 4/3/22.
//

import UIKit
import SafariServices

extension UIViewController {
    
    /**
     * Show alert using the passed title and message
     *
     * - Parameters:
     *    - title: Title of the alert
     *    - message: Information showing the reason for the alert
     *    - buttonTitle: Title of the button that dismisses the alert
     *
     */
    func presentAlert(withTitle title: String, andMessage message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: buttonTitle, style: .cancel)
            
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
        }
    }
    
    /**
     * Show safari browser in app using url passed
     * - Parameters:
     *    - url: URL of the website to open
     */
    func presentSafariViewController(with url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredBarTintColor = .systemBackground
        present(safariViewController, animated: true)
    }
}
