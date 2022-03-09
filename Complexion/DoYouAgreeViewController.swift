//
//  DoYouAgreeViewController.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import UIKit

protocol DoYouAgreeService {
    func load(completion: @escaping (String) -> Void)
}

final class DoYouAgreeServiceOne: DoYouAgreeService {
    func load(completion: @escaping (String) -> Void) {
    }
}

final class DoYouAgreeServiceTwo: DoYouAgreeService {
    func load(completion: @escaping (String) -> Void) {
    }
}

final class DoYouAgreeComposer {
    private init() {}
    
    static func composeWith(a service: DoYouAgreeService) -> DoYouAgreeViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "DoYouAgreeViewController") as! DoYouAgreeViewController
        vc.service = service
        
        return vc
    }
}

protocol DoYouAgreeFlowDelegate: AnyObject {
    func agreed()
    func disagreed()
}

class DoYouAgreeViewController: UIViewController {
    
    var service: DoYouAgreeService?
    
    weak var delegate: DoYouAgreeFlowDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func yesButtonTapped() {
        delegate?.agreed()
    }

    @IBAction private func noButtonTapped() {
        delegate?.disagreed()
    }
}
