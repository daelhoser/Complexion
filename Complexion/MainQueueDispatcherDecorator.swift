//
//  MainQueueDispatcherDecorator.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/7/22.
//

import Foundation

final class MainQueueDispatcherDecorator<T> {
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    private func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        
        completion()
    }
}

extension MainQueueDispatcherDecorator: UserProfileProtocol where T == UserProfileProtocol {
    func get(completion: @escaping (UserProfileProtocol.Result) -> Void) -> RequestTaskProtocol {
        decoratee.get { [weak self] result in
            self?.dispatch {
                completion(result)
                
            }
        }
    }
}

extension MainQueueDispatcherDecorator: LogUserBypassCheckProtocol where T == LogUserBypassCheckProtocol {
    func load(contactId: String, completion: @escaping (LogUserBypassCheckProtocol.Result) -> Void) -> RequestTaskProtocol {
        decoratee.load(contactId: contactId) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
