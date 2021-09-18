//
//  User.swift
//  Firebase Messenger
//
//  Created by Anđelko on 18.Sep.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct User: Codable, Equatable {
    
    var id = ""
    var username: String
    var email: String
    var pushId = ""
    var avatarLink = ""
    var status: String
    
    static var currentId: String {
        return Auth.auth().currentUser!.uid
    }
    
    static var currentUser: User? {
        if Auth.auth().currentUser != nil {
            if let dictionary = UserDefaults.standard.data(forKey: kCURRENTUSER) {
                let decoder = JSONDecoder()
                
                do {
                    let userObject = try decoder.decode(User.self, from: dictionary)
                } catch  {
                    print("Error decoding user from userdefaults", error.localizedDescription)
                }
                
            }
            
            
        }
        return nil
    }
    
    static func == (lhs:User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}

func saveUserLocally ( _ user: User) {
    
    let encoder = JSONEncoder()
    
    do {
       let data = try  encoder.encode(user)
        UserDefaults.standard.set(data, forKey: kCURRENTUSER)
    
    } catch {
        print("saving user locally failed", error.localizedDescription)
    }
   
}
