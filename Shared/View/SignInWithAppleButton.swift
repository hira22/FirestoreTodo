//
//  SignInWithAppleButton.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/08/08.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import AuthenticationServices
import SwiftUI

struct SignInWithAppleButton: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        ASAuthorizationAppleIDButton(
            authorizationButtonType: .signIn, authorizationButtonStyle: .whiteOutline)
    }

    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}
