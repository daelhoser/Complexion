//
//  UserProfile.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import Foundation

struct UserProfile {
    let firstName: String
    let lastName: String
    var contactId: String?
    let locationId: Int
    var accessLevel: AccessLevel = .none
    
    func hasCompletedUserProfile() -> Bool {
        guard let contactId = contactId else {
            return false
        }
        
        return contactId != "0"
    }
    func isAllowedToViewLockedContent() -> Bool {
        return locationId != 123
    }
}
