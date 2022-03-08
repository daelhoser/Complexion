//
//  SetUserAccessLevelToTenProtocol.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import Foundation

protocol SetUserAccessLevelToTenProtocol {
    typealias Result = Swift.Result<Void, Error>
    
    func set(for itemId: String, completion: @escaping (Result) -> Void) -> RequestTaskProtocol
}
