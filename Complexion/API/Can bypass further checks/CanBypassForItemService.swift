//
//  CanBypassForItemService.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import Foundation

final class CanBypassForItemService: CanBypassForItemProtocol {
    func load(itemId: String, completion: @escaping (CanBypassForItemProtocol.Result) -> Void) -> RequestTaskProtocol {
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
            let canBypass = true
            
            completion(.success(canBypass))
        }
        
        return RequestTask()
    }
}
