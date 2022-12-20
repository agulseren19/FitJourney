//
//  SignUpHelper.swift
//  FitJourney
//
//  Created by Aslıhan Gülseren on 20.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore
import FirebaseCore
import GoogleSignIn
import FirebaseCore
import FirebaseStorage

class SignUpHelper{
    var delegate: SignUpDelegate?
    private let storage = Storage.storage().reference()
    
    init() {
    }
    func createAndSaveUser(email:String,password:String){
        Auth.auth().createUser(withEmail: email,
                               password: password) { user, error in
            if error != nil {
                self.delegate?.giveSignUpError(errorDescription: "You have already signed up or this email is incorrect.")
            }
            else {
                        
                        Auth.auth().currentUser?.sendEmailVerification { (error) in
                            let db = Firestore.firestore()
                            db.collection("users").document(email).setData([
                                "email": email,
                                "password": password,
                                "weights": []
                            ]) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                }
                            }
                            self.delegate?.signUpTheUser()
                        }  }}               }
}
