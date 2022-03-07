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
        self.decoratee.get { [weak self] result in
            self?.dispatch(completion: { completion(result) })
        }
    }
}
