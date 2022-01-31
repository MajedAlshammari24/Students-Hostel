

import UIKit
import FirebaseAuth
import FirebaseFirestore
class MyReservationsVC: UIViewController {
    let uid = Auth.auth().currentUser?.uid
    @IBOutlet weak var reserveStatusLabel: UILabel!
    @IBOutlet weak var reserveRoomLabel: UILabel!
    @IBOutlet weak var reservePriceLabel: UILabel!
    
    @IBOutlet weak var frameImage1: UIImageView!
    @IBOutlet weak var frameImage2: UIImageView!
    @IBOutlet weak var frameImage3: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reserveRoomLabel.text?.removeAll()
        reservePriceLabel.text?.removeAll()
        reserveStatusLabel.text?.removeAll()
        reserveStatus()
    }
    
    // MARK: Handle Reservation Status
    fileprivate func reserveStatus() {
        showSpinner()
        Reservation.getStatus(uid: Auth.auth().currentUser?.uid ?? "") { status,error  in
            self.removeSpinner()
            if error == nil {
                if status?.status != "Pending".localized {
                    // if not reserved
                    self.frameImage1.isHidden = true
                    self.frameImage2.isHidden = true
                    self.frameImage3.isHidden = true
                    self.reserveRoomLabel.isHidden = true
                    self.reservePriceLabel.isHidden = true
                    self.reserveStatusLabel.text = "You have no reservation yet!".localized
                } else {
                    // if reserved
                    self.frameImage1.isHidden = false
                    self.frameImage2.isHidden = false
                    self.frameImage3.isHidden = false
                    self.reserveRoomLabel.isHidden = false
                    self.reservePriceLabel.isHidden = false
                    self.reserveRoomLabel.text = status?.roomName
                    self.reservePriceLabel.text = status?.price
                    self.reserveStatusLabel.text = status?.status
                }
            }
        }
    }
    
    // MARK: Delete reservation button
    @IBAction func reserveSettings(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete Reservation".localized, message: "Are you sure you want to delete your reservation?".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete".localized, style: .default){ ok in
            Reservation.deleteReservation(uid: self.uid ?? "")
            self.frameImage1.isHidden = true
            self.frameImage2.isHidden = true
            self.frameImage3.isHidden = true
            self.reserveRoomLabel.isHidden = true
            self.reservePriceLabel.isHidden = true
            self.reserveStatusLabel.text = "You have no reservation yet!".localized
        })
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
}
