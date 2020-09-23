//
//  UserRepository.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/08/08.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class UserRepository: ObservableObject {
    @Published var currentUser: User?

    private var signInWithAppleCoordinator: SignInWithAppleCoordinator!

    init() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        configureUser(uid: uid)
    }
    
    private func configureUser(uid: String) {
        db.collection("users").document(uid)
            .addSnapshotListener { (documentSnapshot: DocumentSnapshot?, error: Error?) in
                if let error = error {
                    print(error)
                    return
                }
                self.currentUser = try! documentSnapshot?.data(as: User.self)
            }
    }

}

// MARK: Sign in Anonymously
extension UserRepository {
    func signInAnonymously() {
        guard Auth.auth().currentUser == nil else { return }
        
        Auth.auth().signInAnonymously { (authDataResult: AuthDataResult?, error: Error?) in
            if let error = error {
                print(error)
                return
            }
            
            let uid: String = authDataResult!.user.uid
            
            if let userInfo: AdditionalUserInfo = authDataResult?.additionalUserInfo,
               userInfo.isNewUser
            {
                _ = try! db.collection("users").document(uid).setData(
                    from: User(id: uid, name: "Anonymous"))
            }
            
            self.configureUser(uid: uid)
        }
    }
}

// MARK: Sign in with Apple
extension UserRepository {
    func linkWithApple(
        coordinator: SignInWithAppleCoordinator = .init(),
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        signInWithAppleCoordinator = coordinator

        signInWithAppleCoordinator.startSignInWithAppleFlow { (idToken: String, nonce: String?) in
            let credential: OAuthCredential = OAuthProvider.credential(
                withProviderID: "apple.com",
                idToken: idToken,
                rawNonce: nonce)
            Auth.auth().currentUser?.link(with: credential) {
                (authDataResult: AuthDataResult?, error: Error?) in
                if let error = error as NSError? {
                    print(error)
                    switch error.code {
                    case AuthErrorCode.credentialAlreadyInUse.rawValue:
                        guard
                            let updatedCredential =
                                error.userInfo[AuthErrorUserInfoUpdatedCredentialKey]
                                as? OAuthCredential
                        else { return }
                        self.signInWithApple(with: updatedCredential, completion: completion)
                    case AuthErrorCode.providerAlreadyLinked.rawValue:
                        self.signInWithApple(with: credential, completion: completion)
                    default: completion(.failure(error))
                    }
                    return
                }

                let uid: String = authDataResult!.user.uid
                self.configureUser(uid: uid)
                completion(.success(()))
            }
        }
    }

    private func signInWithApple(
        with credential: AuthCredential, completion: @escaping (Result<Void, Error>) -> Void
    ) {
        Auth.auth().signIn(with: credential) { (authDataResult: AuthDataResult?, error: Error?) in
            if let error = error {
                completion(.failure(error))
                return
            }

            let uid: String = authDataResult!.user.uid
            self.configureUser(uid: uid)
            completion(.success(()))
        }
    }
}

// MARK: Sign in with Google
extension UserRepository {
    func linkWithGoogle(completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
}
