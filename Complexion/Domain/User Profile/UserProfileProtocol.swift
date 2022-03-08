//
//  UserProfileProtocol.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import Foundation

protocol UserProfileProtocol {
    typealias Result = Swift.Result<UserProfile, Error>
    func get(completion: @escaping (Result) -> Void) -> RequestTaskProtocol
}
