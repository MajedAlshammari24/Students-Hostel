//
//  RegisterVC.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 03/05/1443 AH.
//

import UIKit
import FirebaseAuth
class RegisterVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var studentIDTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func signUp(email: String, password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if authResult?.user.email != nil {
                self?.performSegue(withIdentifier: "Home", sender: nil)
            }
        }
        
        
        
    }
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        signUp(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        
    }
    

}
