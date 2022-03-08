//
//  ThirdPartyCompletionStatusService.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import Foundation

final class ThirdPartyCompletionStatusService: ThirdPartyCompletionStatusProtocol {
    
    func load(completion: @escaping (ThirdPartyCompletionStatusProtocol.Result) -> Void) -> RequestTaskProtocol {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
            let isVerified = true
            
            completion(.success(ThirdPartyResponse(isVerified: isVerified)))
        }
        
        return RequestTask()
    }
}
