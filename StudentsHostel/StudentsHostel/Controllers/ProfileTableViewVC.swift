//
//  ProfileTableViewVC.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 02/06/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class ProfileTableViewVC: UITableViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentEmail: UILabel!
    @IBOutlet weak var studentPhone: UILabel!
    @IBOutlet weak var studentID: UILabel!
    @IBOutlet weak var studentCity: UILabel!
    var selfimageurl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        showSpinner()
        StudentApi.getStudent(uid: Auth.auth().currentUser?.uid ?? "") { student in
            self.removeSpinner()
            self.studentName.text = student.name
            self.studentEmail.text = student.email
            self.studentPhone.text = student.mobileNumber
            self.studentID.text = String(student.studentID ?? 0)
            self.studentCity.text = student.city
            self.selfimageurl = student.imageProfile
            self.saveImageProfile()
        }
    }

    
    
    private func saveImageProfile() {
        guard let url = URL(string: self.selfimageurl ?? "") else {return}
        if let data = try? Data(contentsOf: url) {
            self.profileImageView.image = UIImage(data: data)
        }
    }
    
    
    @IBAction func setProfileImage(_ sender: UIButton) {
        photoPickAlert()
    }
    
    
    @IBAction func logOutButton(_ sender: UIButton) {
        try! Auth.auth().signOut()
        
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    fileprivate func updateStudentInfo() {
        let alert = UIAlertController(title: "Update Profile", message: nil, preferredStyle:.alert)
        
        alert.addTextField(configurationHandler: { textField1 in
            textField1.placeholder = "Name..."
        })
        alert.addTextField(configurationHandler: { textField2 in
            textField2.placeholder = "Email..."
            textField2.keyboardType = .emailAddress
        })
        alert.addTextField(configurationHandler: { textField3 in
            textField3.placeholder = "Mobile Number..."
            textField3.keyboardType = .numberPad
        })
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
            if let studentName = alert.textFields?[0].text,
               let studentEmail = alert.textFields?[1].text,
               let studentMobile = alert.textFields?[2].text {
                Auth.auth().currentUser?.updateEmail(to: studentEmail, completion: { error in
                    if let error = error {
                        print("Something went wrong\(error)")
                    } else {
                        StudentApi.updateInfo(uid: Auth.auth().currentUser?.uid ?? "", name: studentName, email: studentEmail, mobileNumber: studentMobile)
                    }
                })
            }
            self.presentAlert(title: "Done", message:"Your information will change next login")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    @IBAction func editStudentProfile(_ sender: UIBarButtonItem) {
        updateStudentInfo()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 5
        }
    }

}

extension ProfileTableViewVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
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
            self?.profileImageView.image = image
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
