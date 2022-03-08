//
//  LoadUserProfileService.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/7/22.
//

import Foundation

final class LoadUserProfileService : UserProfileProtocol {
    
    func get(completion: @escaping (UserProfileProtocol.Result) -> Void) -> RequestTaskProtocol {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
            let restrictedFromContinuing = false
            let hasCompletedUserProfile = false


            let locationId = restrictedFromContinuing ? 123 : 456            
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
