//
//  User.swift
//  FitJourney
//
//  Created by Aslıhan Gülseren on 21.12.2022.
//

import Foundation

final class User: NSObject {
    static let sharedInstance = User()
    
    var email : String = ""
    var weights = [String]()
    var profilePictureUrl : String = ""
    
    private override init() { }
    
    func setEmail(email : String) {
        self.email = email
    }
    
    func setProfilePictureUrl(profilePictureUrl : String) {
        self.profilePictureUrl = profilePictureUrl
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    
    func setWeightsArray(weights : [String]) {
        self.weights = weights
    }
    
    
    func appendToWeightsArray(id : String) {
        self.weights.append(id)
    }
    
    func getWeightsArray() -> [String] {
        return self.weights
    }
    
    func getWeightsArrayCount () -> Int {
        self.weights.count
    }
    
}
