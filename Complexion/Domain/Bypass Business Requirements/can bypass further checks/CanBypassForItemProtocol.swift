//
//  CanBypassForItemProtocol.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import Foundation

public protocol CanBypassForItemProtocol {
    typealias Result = Swift.Result<Bool, Error>
    
    func load(itemId: String, completion: @escaping (Result) -> Void) -> RequestTaskProtocol
}
