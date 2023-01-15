//
//  ProfileHelper.swift
//  FitJourney
//
//  Created by Begum Sen on 2.01.2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ProfileHelper {
    
    var delegate: ProfileDelegate?
    var userEmail: String?
    var userLastEnteredWeight: Double?
    
    func getUserInfo (){
        let user = User.sharedInstance
        userEmail = user.email
        var userLastEnteredWeightId  = user.getWeightsArray().last
        if let userLastEnteredWeightId = userLastEnteredWeightId {
            let db = Firestore.firestore()
            let docRef2 = db.collection("weights").document(userLastEnteredWeightId)
            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let weightUnwrapped = document.get("weight") as? Double
                    {
                        self.userLastEnteredWeight = weightUnwrapped
                        self.delegate?.weightRangeIsUpdated()
                    }
                }
            }
        }

    }
    
    func signOutTheUser(){
        let userDefault = UserDefaults.standard
        userDefault.setValue("", forKey: "userEmail")
        userDefault.setValue("", forKey: "userPassword")
        self.delegate?.signOut()
    }
}
