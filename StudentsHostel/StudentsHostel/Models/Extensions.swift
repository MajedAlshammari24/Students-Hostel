//
//  Arrays.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 03/05/1443 AH.
//

import Foundation
import UIKit

var spinnerView : UIView?
extension UIViewController {
    func showSpinner() {
        spinnerView = UIView(frame: self.view.bounds)
        spinnerView?.backgroundColor = UIColor(named: "AdaptiveColor")
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.center = spinnerView!.center
        activityIndicator.startAnimating()
        spinnerView?.addSubview(activityIndicator)
        self.view.addSubview(spinnerView!)
    }
    func removeSpinner() {
        spinnerView?.removeFromSuperview()
        spinnerView = nil
    }
}


extension UIViewController {
     func presentAlert(title: String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
       present(alert, animated: true, completion: nil)
    }
    
    
}





let images = [UIImage(named: "Mosque"),UIImage(named: "Theater"),UIImage(named: "Medical"),UIImage(named: "atm"),UIImage(named: "Parking"),UIImage(named: "Stadium"),UIImage(named: "Transport"),UIImage(named: "Router")]
