//
//  UserRepository.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/08/08.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import Foundation

import FirebaseAuth
import FirebaseFirestore

class UserRepository: ObservableObject {
    @Published var currentUser: User?
    
    init() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        configureUser(uid: uid)
    }
    
    func signInAnonymously() {
        Auth.auth().signInAnonymously { (authDataResult: AuthDataResult?, _: Error?) in
            guard let uid: String = authDataResult?.user.uid else { return }
            
            if let userInfo: AdditionalUserInfo = authDataResult?.additionalUserInfo,
                userInfo.isNewUser
            {
                _ = try! db.collection("users").document(uid).setData(from: User(id: uid, name: "Anonymous"))
            }
            
            self.configureUser(uid: uid)
        }
    }
    
    private func configureUser(uid: String) {
        db.collection("users").document(uid)
            .addSnapshotListener { (documentSnapshot: DocumentSnapshot?, error: Error?) in
                if let error = error {
                    print(error)
                }
                self.currentUser = try! documentSnapshot?.data(as: User.self)
            }
    }
}
