//
//  User.swift
//  FirestoreTodo
//
//  Created by hiraoka on 2020/08/08.
//  Copyright © 2020 hiraoka. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Timestamp?
    @ServerTimestamp var updatedAt: Timestamp?

    var name: String
}
