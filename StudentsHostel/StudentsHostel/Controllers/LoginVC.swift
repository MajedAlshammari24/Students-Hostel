//
//  ViewController.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 03/05/1443 AH.
//

import UIKit
import FirebaseAuth
class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: Identifier.home.rawValue, sender: nil)
        }
    }
    
    func signIn(email:String, password:String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if authResult?.user.email != nil {
                self?.performSegue(withIdentifier: Identifier.home.rawValue, sender: nil)
            }
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        signIn(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    
    @IBAction func goToRegisterButton(_ sender: UIButton) {
        performSegue(withIdentifier: Identifier.register.rawValue, sender: nil)
    }
    
}

extension UIViewController {
     func presentAlert(title: String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
       present(alert, animated: true, completion: nil)
    }
}
