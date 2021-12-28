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
    @IBOutlet weak var autoLoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        autoLoginButton.setImage(UIImage(systemName: "app"), for: .normal)
    }
    
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        autoLogin()
    }
    
    func autoLogin() {
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: Identifier.home.rawValue, sender: nil)

        }
    }
   
    
    @IBAction func autoLoginCheckBox(_ sender: UIButton) {
        if sender.image(for: .normal) == UIImage(systemName:"app") {
            sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            
        } else {
            sender.setImage(UIImage(systemName: "app"), for: .normal)
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

