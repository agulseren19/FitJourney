//
//  SignUpDelegate.swift
//  FitJourney
//
//  Created by Aslıhan Gülseren on 20.12.2022.
//

import Foundation
protocol SignUpDelegate {
    func signUpTheUser()
    func giveSignUpError(errorDescription: String)
}
