//
//  WaitingForApprovalViewController.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import UIKit

protocol WaitingForApprovalFlowDelegate: AnyObject {
    func okTapped()
}

class WaitingForApprovalViewController: UIViewController {
    weak var delegate: WaitingForApprovalFlowDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func okButtonTapped() {
        delegate?.okTapped()
    }
}
