//
//  RegisterVC.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 03/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class RegisterVC: UIViewController {
    
    var selectedCity:String?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var studentIDTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPicker()
        dismissPickerView()
    }
    
    func signUp(name:String, email: String, password: String, studentID: Int32, mobileNumber:String, city: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                StudentApi.addStudent(uid: authResult?.user.uid ?? "", name: name, email: email, mobileNumber: mobileNumber, studentID: studentID, city: city) { check in
                    if check {
                        self?.performSegue(withIdentifier: Identifier.home.rawValue, sender: nil)
                    }
                }
            }
        }
    }
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        let name = nameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let city = cityTextField.text
        let mobileNumber = mobileNumberTextField.text
        
        guard let studentID:Int32 = Int32(studentIDTextField.text ?? "") else { return }
        
        signUp(name: name!, email: email!, password: password!, studentID: studentID, mobileNumber: mobileNumber!, city: city!)
    }
    
     
    
    
}

extension RegisterVC:UIPickerViewDelegate,UIPickerViewDataSource{
    
    func createPicker() {
       let pickerView = UIPickerView()
       pickerView.delegate = self
        cityTextField.inputView = pickerView
   }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity = cities[row]
        cityTextField.text = selectedCity
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        cityTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
}
