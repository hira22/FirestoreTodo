//
//  SignInViewModel.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/08/09.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import Combine
import Foundation

class SignInWithAppleViewModel: ObservableObject {
    @Published var hasError: Bool = false
    
    private let userRepository: UserRepository = UserRepository()
    
    func link(succeed: @escaping () -> Void) {
        userRepository.linkWithApple { (result: Result<Void, Error>) in
            switch result {
            case .success(): succeed()
            case .failure: self.hasError = true
            }
        }
    }
}
