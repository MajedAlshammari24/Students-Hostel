//
//  Arrays.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 03/05/1443 AH.
//

import Foundation
import UIKit
import FirebaseAuth
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
    
    func logOutAlert() {
        let alert = UIAlertController(title: "Re login", message: "Please log out to update your information", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Log out", style: .default, handler: { action in
            try! Auth.auth().signOut()
            if let storyboard = self.storyboard {
                let vc = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Later", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
}





let images = [UIImage(named: "Mosque"),UIImage(named: "Theater"),UIImage(named: "Medical"),UIImage(named: "atm"),UIImage(named: "Parking"),UIImage(named: "Stadium"),UIImage(named: "Transport"),UIImage(named: "Router")]
