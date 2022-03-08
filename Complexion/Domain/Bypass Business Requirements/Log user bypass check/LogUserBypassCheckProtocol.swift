//
//  LogUserBypassCheckProtocol.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import Foundation

public protocol LogUserBypassCheckProtocol {
    typealias Result = Swift.Result<Void, Error>
    
    func load(contactId: String, completion: @escaping (Result) -> Void) -> RequestTaskProtocol
}
