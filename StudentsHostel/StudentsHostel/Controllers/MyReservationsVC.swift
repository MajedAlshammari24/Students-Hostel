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
    override func viewDidLoad() {
        super.viewDidLoad()
        if check == true {
            Reservation.getStatus(uid: Auth.auth().currentUser?.uid ?? "") { status in
                self.reserveStatusLabel.text = status.roomName
            }
        } else {
            reserveStatusLabel.text = "You haven't reserve a room yet!"
        }
        
        
        
    }
    

}
