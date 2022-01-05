//
//  MyReservationsVC.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 03/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class MyReservationsVC: UIViewController {
    
    @IBOutlet weak var reserveStatusLabel: UILabel!
    @IBOutlet weak var reserveRoomLabel: UILabel!
    @IBOutlet weak var reservePriceLabel: UILabel!
    
    fileprivate func reserveStatus() {
        Reservation.getStatus(uid: Auth.auth().currentUser?.uid ?? "") { status,error  in
            if error == nil {
                if status?.status != "Pending" {
                    // if not reserved
                    
                    self.reserveRoomLabel.isHidden = true
                    self.reservePriceLabel.isHidden = true
                    self.reserveStatusLabel.text = "You have no reservation yet!"
                    
                } else {
                    // if reserved
                    
                    self.reserveRoomLabel.text = status?.roomName
                    self.reservePriceLabel.text = status?.price
                    self.reserveStatusLabel.text = status?.status
                }
                
            } else {
                self.reserveRoomLabel.isHidden = true
                self.reservePriceLabel.isHidden = true
                self.reserveStatusLabel.text = "You have no reservation yet!"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reserveStatus()
        
        
    }
}
