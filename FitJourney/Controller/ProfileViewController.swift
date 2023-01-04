//
//  ProfileViewController.swift
//  FitJourney
//
//  Created by Begum Sen on 2.01.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHelper = ProfileHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileHelper.delegate = self
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
    @IBAction func signOutButtonTapped(_ sender: Any) {
        profileHelper.signOutTheUser()
    }
    
}

extension ProfileViewController: ProfileDelegate {
    func signOut() {
        if let signIn: UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignIn") as? UIViewController{
            view?.window?.rootViewController = signIn
        }
    }
}
