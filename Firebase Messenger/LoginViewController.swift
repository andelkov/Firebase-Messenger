//
//  LoginViewController.swift
//  Firebase Messenger
//
//  Created by Anđelko on 14.Sep.21.
//

import UIKit
import ProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {

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
    
    //MARK: - Vars
    var isLogin = true
    
    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateUIFor(login: true)
        setupBackgroundTap()
        setupTextFieldDelegates()
        setupBackgroundTap()
    }

    //MARK: - IBActions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        if isDataInputedFor(type: isLogin ? "login" : "register") {
            
        } else {
            ProgressHUD.showFailed("All fields are required")
        }
    }
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        if isDataInputedFor(type: "password") {
            //login or register
        } else {
            ProgressHUD.showFailed("Email is required.")
        }
    }
    @IBAction func resendEmailButtonPressed(_ sender: UIButton) {
        if isDataInputedFor(type: "password") {
            //resend verification email
        } else {
            ProgressHUD.showFailed("Email is required.")
        }
    }
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        updateUIFor(login: sender.titleLabel?.text == "Login")
        isLogin.toggle()
    }
    
    
    //MARK: - Setup
    
    private func setupTextFieldDelegates() {
        emailTextfieldOutlet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextfieldOutlet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        repeatPassTextfieldOutlet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("changing text field")
        updatePLaceholderLabels(textField: textField)
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func backgroundTap() {
        view.endEditing(false)
    }
    
    
    
    //MARK: - Animation
    
    private func updateUIFor(login: Bool) {
        
        signUpButtonOutlet.setTitle(login ? "Sign Up" : "Login" , for: .normal)
        UIView.animate(withDuration: 0.5) {
            self.loginButtonOutlet.setImage(UIImage(named: login ? "loginBtn" : "registerBtn"), for: .normal)
        }
        signUpLabelOutlet.text = login ? "Don't have an account" : "Have an account?"
        UIView.animate(withDuration: 0.5) {
            self.repeatPassTextfieldOutlet.isHidden = login
            self.repeatPassLabelOutlet.isHidden = login
            self.repeatPasswordViewOutlet.isHidden = login
        }
        
        
    }
    
    private func updatePLaceholderLabels(textField: UITextField) {
        switch textField {
        case emailTextfieldOutlet:
            emailTextfieldOutlet.text = textField.hasText ? "Email" : ""
        case passwordTextfieldOutlet:
            passwordTextfieldOutlet.text = textField.hasText ? "Password" : ""
        default:
            repeatPassTextfieldOutlet.text = textField.hasText ? "Repeat password" : ""
        }
        
    }
    
    
    //MARK: - Helpers
    private func isDataInputedFor(type: String ) -> Bool {
        
        switch type {
        case "login":
            return emailTextfieldOutlet.text != "" && passwordTextfieldOutlet.text != ""
        case "registration":
            return emailTextfieldOutlet.text != "" && passwordTextfieldOutlet.text != "" && repeatPassTextfieldOutlet.text != ""
        default:
            return emailTextfieldOutlet.text != ""
        }
    }
    
    
    
}

