//
//  LoadingViewController.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/7/22.
//

import UIKit

final class LoadingViewController: UIViewController {
    private var task: RequestTaskProtocol?
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Loading", comment: "Title for the beginning of the Confidentiality Agreement")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        task?.cancel()
    }
    
    func load(_ loader: () -> (RequestTaskProtocol)) {
        task = loader()
    }
}
