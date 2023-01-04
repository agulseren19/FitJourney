//
//  LaunchScreenViewController.swift
//  FitJourney
//
//  Created by Begum Sen on 2.01.2023.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    let signInHelper = SignInHelper()
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInHelper.delegate = self
        
        let userDefault = UserDefaults.standard
        let userEmail = userDefault.string(forKey: "userEmail")
        let userPassword = userDefault.string(forKey: "userPassword")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if let userEmail = userEmail, let userPassword = userPassword{
                self.signInHelper.checkAndSignIn(userEmail: userEmail, userPassword: userPassword)
            } else {
                self.signInHelper.checkAndSignIn(userEmail: " ", userPassword: " ")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        iconImageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animation()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func animation (){
        UIView.animate(withDuration: 1){
            let size = self.view.frame.size.width * 1.5
            let xPosition = size - self.view.frame.width
            let yPosition = self.view.frame.height - size
            
            self.iconImageView.frame = CGRect(x: -(xPosition/2), y: (yPosition/2), width: size, height: size)
            self.iconImageView.alpha = 0
        }
    }

}

extension LaunchScreenViewController: SignInDelegate {
    
    func signInTheUser() {
        // if the user's email and password is validated
        // the user will be signed in and navigated to home screen
        print("signed in")
        if  let tabBar: UITabBarController = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar") as? UITabBarController{
            //self.navigationController?.pushViewController(tabBar, animated: true)
            view?.window?.rootViewController = tabBar
        }
        self.navigationController?.setNavigationBarHidden(true, animated: true)
 
    }
    
    func giveSignInError( errorDescription: String) {
    }
    
    func doNotSignInTheUser(){
        if let signIn: UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "SignInNavigation") as? UINavigationController{
            view?.window?.rootViewController = signIn
        }
    }
}
