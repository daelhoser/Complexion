//
//  CompleteUserProfileViewController.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/7/22.
//

import UIKit

protocol CompleteProfileFlowDelegate: AnyObject {
    func completeProfileSucceeded(with contactId: Int)
    func completeYourProfileFailed()
}

final class CompleteUserProfileComposer {
    private init() {}
    
    static func compose(with user: UserProfile) -> CompleteUserProfileViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "CompleteUserProfileViewController") as! CompleteUserProfileViewController
        
        return vc
    }
}


final class CompleteUserProfileViewController: UIViewController {
    
    var flowDelegate: CompleteProfileFlowDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        
    @IBAction private func completeWithSuccessButtonTapped() {
        let validContactId = 2
        flowDelegate?.completeProfileSucceeded(with: validContactId)
        
    }
    
    @IBAction private func completeWithFailureButtonTapped() {
        flowDelegate?.completeYourProfileFailed()
    }
}
