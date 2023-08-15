//
//  UIView.swift
//  ConvertCoin
//
//  Created by Matheus Freitas Martins on 14/08/23.
//

import UIKit

extension UIView {
    public func showMessage(view: UIViewController, message: String, title: String = "Attention", btnTitle: String? = "Ok") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: .default, handler: nil))
        view.present(alert, animated: true)
        
    }
}
