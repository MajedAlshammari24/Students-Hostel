//
//  ProfileVC.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 03/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class ProfileVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var studentIDLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StudentApi.getStudent(uid: Auth.auth().currentUser?.uid ?? "") { student in
            
            self.nameLabel.text = student.name
            self.emailLabel.text = student.email
            self.mobileLabel.text = student.mobileNumber
            self.studentIDLabel.text = String(student.studentID ?? 0)
            print(student.studentID)
            self.cityLabel.text = student.city
     }
        
}
    
    

}
