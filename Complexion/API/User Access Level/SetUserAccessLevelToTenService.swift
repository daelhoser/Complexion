//
//  SetUserAccessLevelToTenService.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import Foundation

final class SetUserAccessLevelToTenService: SetUserAccessLevelToTenProtocol {
    func set(for itemId: String, completion: @escaping (SetUserAccessLevelToTenProtocol.Result) -> Void) -> RequestTaskProtocol {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
            completion(.success(()))
        }
        
        return RequestTask()
    }
}
