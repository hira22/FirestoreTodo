//
//  SignInView.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/08/08.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import Combine
import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject private var signInVM: SignInViewModel = SignInViewModel()
    
    @State private var inputTextSubject: CurrentValueSubject<String, Never> = .init("")
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            SignInWithAppleButton()
                .frame(width: 280, height: 45)
                .onTapGesture {
                    self.signInVM.linkWithApple {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
        }
        .alert(isPresented: $signInVM.onError) {
            Alert(title: Text("Error"), message: Text($signInVM.errorMessage.wrappedValue ?? ""), dismissButton: .default(Text("OK")))
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
