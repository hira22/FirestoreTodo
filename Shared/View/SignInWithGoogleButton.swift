//
//  SignInWithGoogleButton.swift
//  FirestoreTodo (iOS)
//
//  Created by hiraoka on 2020/09/22.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import SwiftUI
import GoogleSignIn

struct SignInWithGoogleButton: UIViewRepresentable {
    
    init() {
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
    }
    
    func makeUIView(context: Context) -> GIDSignInButton {
        GIDSignInButton()
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: Context) {}
}
