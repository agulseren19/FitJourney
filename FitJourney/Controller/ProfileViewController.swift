//
//  ProfileViewController.swift
//  FitJourney
//
//  Created by Begum Sen on 2.01.2023.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    let profileHelper = ProfileHelper()
    let profilePictureHelper = ProfilePictureHelper()
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var weightRangeLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    private var profileImage: UIImage = UIImage(named: "defaultProfile")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileHelper.delegate = self
        profilePictureHelper.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileHelper.getUserInfo()
        self.profileImageView.kf.indicatorType = .activity
                self.profileImageView.kf.setImage(with: URL(string: User.sharedInstance.profilePictureUrl), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
                self.profileImageView.layer.borderWidth = 1.0
                self.profileImageView.layer.masksToBounds = false
                self.profileImageView.layer.borderColor = UIColor.white.cgColor
                self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
                self.profileImageView.clipsToBounds = true
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
    
    @IBAction func uploadImageTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    
}

extension ProfileViewController: ProfileDelegate {
    func weightRangeIsUpdated() {
        emailLabel.text = profileHelper.userEmail
        weightRangeLabel.text = "Last Entered Weight: \(profileHelper.userLastEnteredWeight ?? 0.0) kg"
    }
    
    func signOut() {
        if let signIn: UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "SignInNavigation") as? UINavigationController{
            view?.window?.rootViewController = signIn
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImage = image
        } else{
            return
        }
        
        self.profileImageView.image = self.profileImage
        self.profileImageView.layer.borderWidth = 1.0
        self.profileImageView.layer.masksToBounds = false
        self.profileImageView.layer.borderColor = UIColor.white.cgColor
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        self.profileImageView.clipsToBounds = true
        
        guard let imageData = profileImage.pngData() else {
            print("image cannot be updated")
            return
        }
        profilePictureHelper.setImageUrl(email: User.sharedInstance.getEmail(), imageData: imageData)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension ProfileViewController: UINavigationControllerDelegate{
    
}
