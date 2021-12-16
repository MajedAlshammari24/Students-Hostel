//
//  Indicator.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 11/05/1443 AH.
//
import UIKit
import Foundation

class Indicator: NSObject {
  static func start(view:UIView,activityIndicator : UIActivityIndicatorView, isUserInteractionEnabled : Bool) -> Void {
    view.endEditing(true)
    activityIndicator.startAnimating()
    view.bringSubviewToFront(activityIndicator)
    view.isUserInteractionEnabled = isUserInteractionEnabled
    activityIndicator.center = view.center
    view.addSubview(activityIndicator)
  }
  static func stop(view:UIView,activityIndicator : UIActivityIndicatorView) -> Void {
    activityIndicator.stopAnimating()
    activityIndicator.removeFromSuperview()
    view.isUserInteractionEnabled = true
  }
    
}
