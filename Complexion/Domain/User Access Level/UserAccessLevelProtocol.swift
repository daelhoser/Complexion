//
//  UserAccessLevelProtocol.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import Foundation

public protocol UserAccessLevelProtocol {
    typealias Result = Swift.Result<AccessLevel, Error>
    
    func load(with listingId: String, completion: @escaping (Result) -> Void) -> RequestTaskProtocol
}
