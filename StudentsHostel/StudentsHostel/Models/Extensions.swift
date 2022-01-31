

import Foundation
import UIKit
import FirebaseAuth

enum Identifier: String {
    case home
    case roomSelect
    case register
    case terms
    case completion
}

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

extension Notification.Name {
    static let darkModeEnabled = Notification.Name("com.yourApp.notifications.darkModeEnabled")
    static let darkModeDisabled = Notification.Name("com.yourApp.notifications.darkModeDisabled")
}

extension UIImage {
    var circleMask: UIImage? {
        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
        let imageView = UIImageView(frame: .init(origin: .init(x: 0, y: 0), size: square))
        imageView.contentMode = .scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


extension UIViewController {
     func presentAlert(title: String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
       present(alert, animated: true, completion: nil)
    }
    
    func termsAlert(){
        let alert = UIAlertController(title: "You did not agree", message: "Please Agree to our terms and conditions", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Terms And Conditions", style: .default, handler: { terms in
            self.performSegue(withIdentifier: Identifier.terms.rawValue, sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension UIImageView {
    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

extension UIView{
    func setCornerStyle(){
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 2.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 12.0
    }
}

extension String{
    var localized:String{
        NSLocalizedString(self, comment: "")
    }
}

let cities = ["","Abha".localized,"Buraydah".localized,"AlBahah".localized,"Buq a".localized,"Dammam".localized,"Dhahran".localized,"Dumat Al-Jandal".localized,"Dawadmi".localized,"Hail".localized,"Hotat Bani Tamim".localized,"Hofuf".localized,"Hafr Al-Batin".localized,"Jeddah".localized,"Khafji".localized,"Khamis Mushait".localized,"Khobar".localized,"Al Majma'ah".localized,"Medina".localized,"Mecca".localized,"Qatif".localized,"Qurayyat".localized,"Rabegh".localized,"Rafha".localized,"Riyadh".localized,"Taif".localized,"Tabuk".localized,"Yanbu".localized]



