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

    var activityIndicatorContainer: UIActivityIndicatorView!

    var selfimageurl : String?

    
    var acivityIndicator : UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        
        showSpinner()
        StudentApi.getStudent(uid: Auth.auth().currentUser?.uid ?? "") {
            student in
            self.removeSpinner()
            self.nameLabel.text = student.name
            self.emailLabel.text = student.email
            self.mobileLabel.text = student.mobileNumber
            self.selfimageurl = student.imageProfile
            self.saveImageProfile()
            self.studentIDLabel.text = "\(student.studentID ?? 0)"
            self.cityLabel.text = student.city
        }
    }
    
 

    @IBAction func imageProfileButton(_ sender: UIButton) {
        self.photoPickAlert()
    }
    
    
      
    private func saveImageProfile() {
        guard let url = URL(string: self.selfimageurl ?? "") else {return}
        if let data = try? Data(contentsOf: url) {
            self.profileImage.image = UIImage(data: data)
        }
    }
    
    @IBAction func modeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        } else {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        try! Auth.auth().signOut()
        
//        performSegue(withIdentifier: "loginVC", sender: nil)
                if let storyboard = self.storyboard {
                    let vc = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
    }
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    private func photoPickAlert() {
        
        let alert = UIAlertController(title: "Choose Your Photo", message: "From where you want to pick the photo?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getProfileImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getProfileImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
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
            StudentApi.uploadStudentImage(studentImage: image) { check, url in
                if check {
                    StudentApi.addImageProfile(uid: Auth.auth().currentUser?.uid ?? "", url: url ?? "")
                }
            }
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

