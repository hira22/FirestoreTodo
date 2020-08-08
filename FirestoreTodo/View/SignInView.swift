//
//  SignInView.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/08/08.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            SignInWithAppleButton()
                .frame(width: 280, height: 45)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
