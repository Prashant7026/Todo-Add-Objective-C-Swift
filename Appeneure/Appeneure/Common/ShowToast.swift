//
//  ShowToast.swift
//  Appeneure
//
//  Created by Prashant Kumar Soni on 07/12/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showToast(message: String, font: UIFont = UIFont.systemFont(ofSize: 14), position: CGPoint? = nil, duration: TimeInterval = 4.0) {
        // Default position: bottom center
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0
        
        // Set position
        let toastWidth: CGFloat = 200
        let toastHeight: CGFloat = 30
        let position = position ?? CGPoint(x: self.view.frame.size.width / 2 - toastWidth / 2, y: self.view.frame.size.height - toastHeight - 500)
        
        toastLabel.frame = CGRect(x: position.x, y: position.y, width: toastWidth, height: toastHeight)
        
        self.view.addSubview(toastLabel)
        
        // Animate and remove toast
        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
}

