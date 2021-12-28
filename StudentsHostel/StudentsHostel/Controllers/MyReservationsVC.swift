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
    override func viewDidLoad() {
        super.viewDidLoad()
            Reservation.getStatus(uid: Auth.auth().currentUser?.uid ?? "") { status in
                self.reserveRoomLabel.text = status.roomName
                self.reservePriceLabel.text = status.price
                self.reserveStatusLabel.text = status.status
            }
       
        
        
        
    }
    

}
