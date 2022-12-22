//
//  SignUpViewController.swift
//  FitJourney
//
//  Created by Aslıhan Gülseren on 20.12.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import FirebaseStorage
class SignUpViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signUpImageView: UIImageView!
    
    @IBOutlet weak var errorText: UILabel!
    let signUpHelper = SignUpHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpHelper.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
              NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signUpButtonIsClicked(_ sender: UIButton) {
        let email = emailField.text!
        let password = passwordField.text!
        signUpHelper.createAndSaveUser(email:email,password:password)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let  signUpImageView=signUpImageView , let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
           return
        }
        self.view.frame.origin.y = 200 - keyboardSize.height
        signUpImageView.isHidden=true

    }
    @objc func keyboardWillHide(notification: NSNotification) {
      self.view.frame.origin.y = 0
        signUpImageView.isHidden=false

    }
}
extension SignUpViewController: SignUpDelegate {
    func signUpTheUser() {
        // if the user's email and password is validated
        // the user will be signed up and navigated to next screen
   /*asli
    let secondSignUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondSignUpViewController") as! SecondSignUpViewController
    secondSignUpViewController.userEmail=self.emailField.text!
    self.navigationController?.pushViewController(secondSignUpViewController, animated:true)
    */
        emailField.delegate = self
        passwordField.delegate = self
        self.navigationController?.popToRootViewController(animated: true)
        errorText.text = ""
        passwordField.text = ""
        emailField.text = ""
    }
    
    func giveSignUpError( errorDescription: String) {
        errorText.text = errorDescription
        errorText.isHidden = false
        errorText.textColor = UIColor.red
        errorText.adjustsFontSizeToFitWidth = true
    }
}

extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

