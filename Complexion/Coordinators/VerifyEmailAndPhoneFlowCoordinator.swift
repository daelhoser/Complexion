//
//  VerifyEmailAndPhoneFlowCoordinator.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import Foundation
import UIKit

final class VerifyEmailAndPhoneFlowCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
        
    weak var completionDelegate: EmailAndPhoneVerificationStatusDelegate?

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "VerifyEmailAndPhoneViewController") as! VerifyEmailAndPhoneViewController
        vc.completionDelegate = self

        navigationController.setViewControllers([vc], animated: true)
    }
}

extension VerifyEmailAndPhoneFlowCoordinator: EmailAndPhoneVerificationStatusDelegate {
    func completedSuccessfully() {
        completionDelegate?.completedSuccessfully()
    }
    
    func cancelled() {
        completionDelegate?.cancelled()
    }
    
    func failed() {
        completionDelegate?.failed()
    }
    
    
}
