//
//  DatabaseManager.swift
//  AllChat
//
//  Created by Ahmet Durmuş on 21.08.2022.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}
extension DatabaseManager {
        public func userExists(with email: String,
                               completion: @escaping ((Bool) -> Void)) {
            
            var safeemail = email.replacingOccurrences(of: ".", with: "-")
            safeemail = safeemail.replacingOccurrences(of: "@", with: "-")
            
            database.child(safeemail).observeSingleEvent(of: .value) { snapShot in
                guard snapShot.value as? String != nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        
        /// inserts new users to database
        public func insertUser(with user: ChatAppUser) {
            
            database.child(user.safeEmail).setValue([
                "first_name": user.firstName,
                "last_name": user.lastName
            ])
            
        }
  
    
    struct ChatAppUser {
        let firstName: String
        let lastName: String
        let emailAddress: String
//        let profilePictureUrl: String
        
        var safeEmail: String {
            var safeemail = emailAddress.replacingOccurrences(of: ".", with: "-")
            safeemail = safeemail.replacingOccurrences(of: "@", with: "-")
            return safeemail
        }
    }
}
