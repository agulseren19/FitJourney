//
//  ViewController.swift
//  FitJourney
//
//  Created by Aslıhan Gülseren on 19.12.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import FirebaseStorage
class SignInViewController: UIViewController {

    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    let signInHelper = SignInHelper()
    @IBAction func signInButtonClicked(_ sender: UIButton) {
        guard let userEmail = emailField.text,
            let userPassword = passwordField.text
        else{
            return
        }
        signInHelper.checkAndSignIn(userEmail: userEmail, userPassword: userPassword)
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signInHelper.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
              NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       /* let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
              tap.cancelsTouchesInView = false
              view.addGestureRecognizer(tap) */

    }
    override func viewWillDisappear(_ animated: Bool) {
      //  self.navigationController?.setNavigationBarHidden(true, animated: animated) asli
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let  exerciseImage=exerciseImage , let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
           return
        }
      
      self.view.frame.origin.y = 200 - keyboardSize.height
        exerciseImage.isHidden=true

    }
    @objc func keyboardWillHide(notification: NSNotification) {
      self.view.frame.origin.y = 0
        exerciseImage.isHidden=false

    }



}
extension SignInViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
extension SignInViewController: SignInDelegate {
    func signInTheUser() {
        // if the user's email and password is validated
        // the user will be signed in and navigated to home screen
        print("signed in")
        if  let tabBar: UITabBarController = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar") as? UITabBarController{
            self.navigationController?.pushViewController(tabBar, animated: true)
            errorLabel.text = ""
            passwordField.text = ""
            emailField.text = ""
        }
        self.navigationController?.setNavigationBarHidden(true, animated: true)
 
    }
    
    func giveSignInError( errorDescription: String) {
        errorLabel.text = errorDescription
        errorLabel.isHidden = false
        errorLabel.textColor = UIColor.red
        errorLabel.adjustsFontSizeToFitWidth = true
    }
}

