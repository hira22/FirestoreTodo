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
    @Environment(\.presentationMode) var presentationMode
    
    @State var showAlert: Bool = false
    
    @ObservedObject var signInWithAppleVM: SignInWithAppleViewModel = SignInWithAppleViewModel()
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        signInWithAppleVM.$hasError
            .assign(to: \.showAlert, on: self)
            .store(in: &cancellableSet)
    }
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            SignInWithAppleButton()
                .frame(width: 280, height: 45)
                .onTapGesture {
                    self.signInWithAppleVM.link {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("oh, no. we have some error. "), dismissButton: .default(Text("OK")))
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
