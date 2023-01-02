//
//  SignInDelegate.swift
//  FitJourney
//
//  Created by Aslıhan Gülseren on 20.12.2022.
//

import Foundation
protocol SignInDelegate{
    func signInTheUser()
    func giveSignInError(errorDescription: String)
    func doNotSignInTheUser()
}

extension SignInDelegate {
    func doNotSignInTheUser(){}
}
