//
//  FirebaseUserListener.swift
//  Firebase Messenger
//
//  Created by Anđelko on 18.Sep.21.
//

import Foundation
import Firebase

class FirebaseUserListener {
    static let shared = FirebaseUserListener()
    
    private init() {}
    
    //MARK: - Login
    func loginUserWithEmail(email: String, password:String, completion: @escaping(_ error: Error?, _ isEmailVerified: Bool) -> Bool ) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            
            if error == nil && authDataResult!.user.isEmailVerified {
                
                FirebaseUserListener.shared.downloadUserFromFirebase(userID: authDataResult!.user.uid, email: email )
                
                completion(error, true)
            } else {
                print("email is not verified")
                completion(error, false)
            }
        }
    }
    
    //MARK: - Register
    
    func registerUserWith(email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            completion(error)
            
            
            //send verification email
            if error == nil {
                authDataResult!.user.sendEmailVerification(completion: { (error) in
                    print("auth email sent with error", error?.localizedDescription)
                })
            }
            
            //create user and save it
            
            if authDataResult?.user != nil {
                
                let user = User(id: authDataResult!.user.uid, username: email, email: email, pushId: "", avatarLink: "", status: "Hey there. I'm using Messenger.")
                saveUserLocally(user)
                self.saveUserToFirestore(user)
            }
            
            
            
        }
        
        
    }
    
    //MARK: - Resend link methods
    func resendVerificationEmail(email: String, completion: @escaping(_ error: Error?) -> Void ) {
        Auth.auth().currentUser?.reload(completion: { (error) in
            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                completion(error)
            })
        })
        
    }
    
    func resendPasswordFor (email: String, completion: @escaping(_ error: Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            completion(error)
        }
    }
    
    //MARK: - Save users
    
    func saveUserToFirestore(_ user: User) {
        do {
            try FirebaseReference(.User).document(user.id).setData(from: user)
        } catch {
            print(error.localizedDescription, "adding user")
        }
    }
    
    //MARK: - Download
    
    func downloadUserFromFirebase(userID: String, email: String? = nil) {
        
        FirebaseReference(.User).document(userID).getDocument { (querySnapshot, error) in
            guard let document = querySnapshot else {
                print("no document for user found")
                return
            }
            
            let result = Result {
                try? document.data(as: User.self)
            }
            
            switch result {
            case .success(let userObject):
                if let user = userObject {
                    saveUserLocally(user)
                } else {
                    print("The document doesnt exist")
                }
            case .failure(let error):
                print("Error decoding user", error)
            }
        }
        
    }
    
}
