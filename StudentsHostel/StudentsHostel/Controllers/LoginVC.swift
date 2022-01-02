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
    var rememberMeClick = false
    override func viewDidLoad() {
        super.viewDidLoad()
        rememberMeCheck()
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
        if (rememberMeClick == false) {
            if let image = UIImage(systemName: "checkmark.square") {
                autoLoginButton.setBackgroundImage(image, for: .normal)
            }
            rememberMeClick = true
            
        } else {
            if let image = UIImage(systemName: "app") {
                autoLoginButton.setBackgroundImage(image, for: .normal)
            }
            rememberMeClick = false
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
        if (rememberMeClick == true) {
            UserDefaults.standard.set("save", forKey: "rememberMe")
            UserDefaults.standard.set(emailTextField.text, forKey: "email")
            UserDefaults.standard.set(passwordTextField.text, forKey: "password")
        } else {
            UserDefaults.standard.set("unsave", forKey: "rememberMe")
        }
    }
    
    func rememberMeCheck() {
        if UserDefaults.standard.string(forKey: "rememberMe") == "save" {
            if let image = UIImage(systemName: "checkmark.square") {
                autoLoginButton.setBackgroundImage(image, for: .normal)
            }
            rememberMeClick = true
            emailTextField.text = UserDefaults.standard.string(forKey: "email")
            passwordTextField.text = UserDefaults.standard.string(forKey: "password")
        } else {
            if let image = UIImage(systemName: "app") {
                autoLoginButton.setBackgroundImage(image, for: .normal)
            }
            rememberMeClick = false
        }
    }
    
    @IBAction func goToRegisterButton(_ sender: UIButton) {
        performSegue(withIdentifier: Identifier.register.rawValue, sender: nil)
    }
    
}

