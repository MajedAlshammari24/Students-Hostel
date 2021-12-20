//
//  Arrays.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 03/05/1443 AH.
//

import Foundation
import UIKit

var aView : UIView?
extension UIViewController {
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor(named: "AdaptiveColor")
        let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
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
