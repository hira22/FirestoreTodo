//
//  SignInViewModel.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/08/09.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import Combine
import Foundation

class SignInViewModel: ObservableObject {
    @Published var onError: Bool = false
    @Published var errorMessage: String?

    private let userRepository: UserRepository

    init(repository: UserRepository = .init()) {
        userRepository = repository
    }

    func linkWithApple(succeed: @escaping () -> Void) {
        userRepository.linkWithApple { (result: Result<Void, Error>) in
            switch result {
            case .success(): succeed()
            case let .failure(error):
                self.onError = true
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
