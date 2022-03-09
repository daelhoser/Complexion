//
//  LogUserBypassCheckService.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import Foundation

final class LogUserBypassCheckService: LogUserBypassCheckProtocol {
    
    func load(contactId: String, completion: @escaping (LogUserBypassCheckProtocol.Result) -> Void) -> RequestTaskProtocol {
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(500)) {
            completion(.success(()))
        }
        
        return RequestTask()
    }
}
