//
//  FCollectionReference.swift
//  Firebase Messenger
//
//  Created by Anđelko on 18.Sep.21.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Recent
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
    
}
