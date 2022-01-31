

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
    @IBOutlet weak var selectLangBtn: UIButton!
    @IBOutlet weak var appeareanceSwitch: UISwitch!
    var userDefault = UserDefaults.standard
    var selfImageUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectLangBtn.setTitle("عربي".localized, for: .normal)
        fetchStudentProfile()
        profileImageView.makeRounded()
        if UserDefaults.standard.bool(forKey: "isDark") == true{
            appeareanceSwitch.setOn(true, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // MARK: Gesture Recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tap)
    }
    
    
    @objc func didTapImage(){
        photoPickAlert()
    }
    
    // MARK: Students Information Function
    func fetchStudentProfile() {
        showSpinner()
        StudentApi.getStudent(uid: Auth.auth().currentUser?.uid ?? "") { student in
            self.removeSpinner()
            self.studentName.text = student.name
            self.studentEmail.text = student.email
            self.studentPhone.text = student.mobileNumber
            self.studentID.text = String(student.studentID ?? 0)
            self.studentCity.text = student.city?.localized
            self.selfImageUrl = student.imageProfile
            self.saveImageProfile()
        }
    }
    
    // MARK: Student ImageProfile Saving Function
    private func saveImageProfile() {
        guard let url = URL(string: self.selfImageUrl ?? "") else {return}
        if let data = try? Data(contentsOf: url) {
            self.profileImageView.image = UIImage(data: data)
        }
    }
    
    
    // MARK: Logout
    @IBAction func logOutButton(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        }catch let error{
            print(error)
        }
        
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: Update Students Info Function
    fileprivate func updateStudentInfo() {
        let alert = UIAlertController(title: "Update Profile".localized, message: nil, preferredStyle:.alert)
        
        alert.addTextField(configurationHandler: { textField1 in
            textField1.text = self.studentName.text
        })
        alert.addTextField(configurationHandler: { textField2 in
            textField2.text = self.studentEmail.text
            textField2.keyboardType = .emailAddress
        })
        alert.addTextField(configurationHandler: { textField3 in
            textField3.text = self.studentPhone.text
            textField3.keyboardType = .numberPad
        })
        alert.addAction(UIAlertAction(title: "Confirm".localized, style: .default, handler: { action in
            if let studentName = alert.textFields?[0].text,
               let studentEmail = alert.textFields?[1].text,
               let studentMobile = alert.textFields?[2].text {
                Auth.auth().currentUser?.updateEmail(to: studentEmail, completion: { error in
                    if let error = error {
                        print("Something went wrong\(error)")
                    } else {
                        if !studentName.isEmpty, !studentEmail.isEmpty, !studentMobile.isEmpty {
                            StudentApi.updateInfo(uid: Auth.auth().currentUser?.uid ?? "", name: studentName, email: studentEmail, mobileNumber: studentMobile)
                            self.fetchStudentProfile()
                            self.tableView.reloadData()
                            self.presentAlert(title: "Done".localized, message:"Your information updated successfully".localized)
                        } else{
                            self.presentAlert(title: "Update Error".localized, message: "Fields can't be empty!".localized)
                        }
                    }
                })
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    @IBAction func appAppearance(_ sender: UISwitch) {
        
        if appeareanceSwitch.isOn{
            userDefault.set(true, forKey: "isDark")
            UIApplication.shared.windows.forEach { windows in
                windows.overrideUserInterfaceStyle = .dark
            }
        } else {
            userDefault.set(false, forKey: "isDark")
            UIApplication.shared.windows.forEach { windows in
                windows.overrideUserInterfaceStyle = .light
            }
        }
    }
    
    @IBAction func selectLanguage(_ sender: UIButton) {
        let currentLanguage = Locale.current.languageCode
        
        let alert = UIAlertController(title: "Warning".localized, message: "The application will be restarted".localized, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Restart".localized, style: .default) { restart in
            let newLanguage = currentLanguage == "en" ? "ar" : "en"
            UserDefaults.standard.setValue([newLanguage], forKey: "AppleLanguages")
            exit(0)
        })
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel))
        present(alert, animated: true)
    }
    
    
    
    // MARK: Update Info Button
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        50
    }
    
}

// MARK: ImagePicker
extension ProfileTableViewVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    private func photoPickAlert() {
        
        let alert = UIAlertController(title: "Choose Your Photo".localized, message: "From where you want to pick the photo?".localized, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera".localized, style: .default, handler: {(action: UIAlertAction) in
            self.getProfileImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album".localized, style: .default, handler: {(action: UIAlertAction) in
            self.getProfileImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Delete photo".localized, style: .default, handler: { delete in
            self.profileImageView.image = UIImage(systemName: "plus.circle")
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .destructive, handler: nil))
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
