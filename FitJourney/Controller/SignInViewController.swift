//
//  ViewController.swift
//  FitJourney
//
//  Created by Aslıhan Gülseren on 19.12.2022.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    let signInHelper = SignInHelper()
    @IBAction func signInButtonClicked(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

