//
//  ThirdPartyCompletionStatusProtocol.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import Foundation

struct ThirdPartyResponse {
    let isVerified: Bool
}

protocol ThirdPartyCompletionStatusProtocol {
    typealias Result = Swift.Result<ThirdPartyResponse, Error>
    
    func load(completion: @escaping (Result) -> Void) -> RequestTaskProtocol
}
