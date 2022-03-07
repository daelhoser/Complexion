//
//  LoadUserProfileService.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/7/22.
//

import Foundation

struct UserProfile {
    
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
            let user = UserProfile()
            
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
