//
//  LoginViewController.swift
//  Monday
//
//  Created by Agus Riady on 09/07/21.
//

import UIKit
import Firebase

@objc(EmailViewController)
class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
        
    @IBAction func loginBtn(_ sender: UIButton) {
        let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                let dialogMessage = UIAlertController(title: "Login Gagal", message: "\n Username / Password salah! Silahkan coba lagi!", preferredStyle: .alert)
                // Create OK button with action handler
                let ok = UIAlertAction(title: "Kembali", style: .default, handler: { (action) -> Void in
                    print("Password salah Ok button tapped")
                 })
                
                //Add OK button to a dialog message
                dialogMessage.addAction(ok)
                // Present Alert to
                self.present(dialogMessage, animated: true, completion: nil)
            }
            else {
                let userDefaultStore = UserDefaults.standard
                userDefaultStore.set(self.emailField.text, forKey: "email")
                
                let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "TabbarViewController")
                newViewController.modalPresentationStyle = .fullScreen
                self.show(newViewController, sender: self)
            }
        }
    }
}
