//
//  ProfileHelper.swift
//  FitJourney
//
//  Created by Begum Sen on 2.01.2023.
//

import Foundation

class ProfileHelper {
    
    var delegate: ProfileDelegate?
    
    func signOutTheUser(){
        let userDefault = UserDefaults.standard
        userDefault.setValue("", forKey: "userEmail")
        userDefault.setValue("", forKey: "userPassword")
        self.delegate?.signOut()
    }
}
