//
//  LoginViewController.swift
//  Firebase Messenger
//
//  Created by Anđelko on 14.Sep.21.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - IBOutlets
    //labels
    @IBOutlet weak var emailLabelOutlet: UILabel!
    @IBOutlet weak var passwordLabelOutlet: UILabel!
    @IBOutlet weak var repeatPassLabelOutlet: UILabel!
    @IBOutlet weak var signUpLabelOutlet: UILabel!
    
    //textfields
    @IBOutlet weak var emailTextfieldOutlet: UITextField!
    @IBOutlet weak var passwordTextfieldOutlet: UITextField!
    @IBOutlet weak var repeatPassTextfieldOutlet: UITextField!
    
    //buttons
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var resendEmailButtonOutlet: UIButton!
    
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    
    //views
    @IBOutlet weak var repeatPasswordViewOutlet: UIView!
    
    
    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK: - IBActions
    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
    }
    @IBAction func resendEmailButtonPressed(_ sender: Any) {
    }
    @IBAction func signUpButtonPressed(_ sender: Any) {
    }
}

