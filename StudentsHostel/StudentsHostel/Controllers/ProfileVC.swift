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
    @IBOutlet weak var profileImage: UIImageView!
    
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
    @IBAction func addImageButton(_ sender: Any) {
    }
    @IBAction func logOutButton(_ sender: UIButton) {
        try! Auth.auth().signOut()
        
        performSegue(withIdentifier: "loginVC", sender: nil)
//        if let storyboard = self.storyboard {
//            let vc = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
//            vc.presentationController?.presentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
//        }
    }
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func getProfileImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            present(imagePickerController, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true) { [weak self] in
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            self?.profileImage.image = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
