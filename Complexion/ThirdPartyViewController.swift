//
//  ThirdPartyViewController.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import UIKit


final class ThirdPartyViewController: UIViewController {
    static let thirdPartySucceededNotificationName = "thirdPartySucceededNotificationName"
    static let thirdPartyFailedNotificationName = "thirdPartyFailedNotificationName"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func completeWithSuccessButtonTapped() {
        NotificationCenter.default.post(name: Notification.Name(ThirdPartyViewController.thirdPartySucceededNotificationName), object: nil)
    }
    
    @IBAction private func completeWithFailureButtonTapped() {
        NotificationCenter.default.post(name: Notification.Name(ThirdPartyViewController.thirdPartyFailedNotificationName), object: nil)
    }
}
