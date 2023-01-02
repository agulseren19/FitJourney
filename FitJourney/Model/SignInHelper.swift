//
//  SignInHelper.swift
//  FitJourney
//
//  Created by Aslıhan Gülseren on 20.12.2022.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
class SignInHelper {
    
    var delegate: SignInDelegate?
    
    func checkAndSignIn (userEmail: String, userPassword: String) {
        var responseText: String = ""
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (authResult, error) in
          if let authResult = authResult {
            let user = authResult.user
            if user.isEmailVerified {
                // user can sign in
                self.createTheUser(userEmail: userEmail, userPassword: userPassword) //FLAG
            } else {
              // user's email is not verified
                self.delegate?.giveSignInError(errorDescription: "Cant Sign in user. Verification needed")
                self.delegate?.doNotSignInTheUser()
            }
          }
          if let error = error {
              responseText = error.localizedDescription
              self.delegate?.giveSignInError(errorDescription: responseText)
              self.delegate?.doNotSignInTheUser()
          }
        }
         
    }
    
    func createTheUser (userEmail: String, userPassword: String) {
        
        var user = User.sharedInstance
        
         let db = Firestore.firestore()
         let docRef = db.collection("users").document(userEmail)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                user.setEmail(email: userEmail)
              //  user.setPassword(password: document.get("password")! as! String)
                user.setWeightsArray(weights: document.data()!["weights"]! as! [String])
                let userDefault = UserDefaults.standard
                userDefault.setValue(userEmail, forKey: "userEmail")
                userDefault.setValue(userPassword, forKey: "userPassword")
                self.delegate?.signInTheUser()
            } else {
                print("Document does not exist")
            }
        }
    }
    

    
}
