//
//  LoadUserProfileService.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/7/22.
//

import Foundation

struct UserProfile {
    let firstName: String
    let lastName: String
    let contactId: String?
    let locationId: Int
    
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

protocol UserProfileProtocol {
    typealias Result = Swift.Result<UserProfile, Error>
    func get(completion: @escaping (Result) -> Void) -> RequestTaskProtocol
}

struct RequestTask: RequestTaskProtocol {
    func cancel() {
    }
}

final class LoadUserProfileService : UserProfileProtocol {
    
    func get(completion: @escaping (UserProfileProtocol.Result) -> Void) -> RequestTaskProtocol {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
            let restrictedFromContinuing = true
            let locationId = restrictedFromContinuing ? 123 : 456
            
            let hasCompletedUserProfile = true
            let contactId: String? = hasCompletedUserProfile ? "1" : nil
            let user = UserProfile(firstName: "Jose", lastName: "Alvarez", contactId: contactId, locationId: locationId)
            
            completion(.success(user))
        }
        
        return RequestTask()
    }
}


extension LoadUserProfileService {
    static func wrappedInMain() -> MainQueueDispatcherDecorator<LoadUserProfileService> {
        return MainQueueDispatcherDecorator(decoratee: LoadUserProfileService())
    }
}
