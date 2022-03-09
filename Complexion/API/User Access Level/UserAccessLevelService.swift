//
//  UserAccessLevelService.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import Foundation

final class UserAccessLevelService: UserAccessLevelProtocol {
    func load(with listingId: String, completion: @escaping (UserAccessLevelProtocol.Result) -> Void) -> RequestTaskProtocol {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(500)) {
            let userAccessLevel = AccessLevel.ten
            
            completion(.success(userAccessLevel))
        }
        
        return RequestTask()
    }
}
