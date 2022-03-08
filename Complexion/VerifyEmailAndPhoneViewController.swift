//
//  VerifyEmailAndPhoneViewController.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import UIKit

protocol EmailAndPhoneVerificationStatusDelegate: AnyObject {
    func completedSuccessfully()
    func cancelled()
    func failed()
}

final class VerifyEmailAndPhoneViewController: UIViewController {
    weak var completionDelegate: EmailAndPhoneVerificationStatusDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func completeWithSuccessButtonTapped() {
        completionDelegate?.completedSuccessfully()
        
    }
    
    @IBAction private func completeWithFailureButtonTapped() {
        completionDelegate?.failed()
    }
    
    @IBAction private func userCancelled() {
        completionDelegate?.cancelled()
    }
}
