//
//  ViewController.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/6/22.
//

import UIKit

class ViewController: UIViewController {
    var coordinator: RootCoordinator?

    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction private func unlockButtonTapped() {
        let navController = UINavigationController()
        let listingAccessLevel = AccessLevel.twenty
        
        coordinator = RootCoordinator(navigationController: navController, listingAccessLevel: listingAccessLevel)
        
        coordinator?.onCompletion = { [weak self] completed in
            if completed {
                self?.statusLabel.text = "You've completed your requirements. You should request data from backend and update UI"
            } else {
                self?.statusLabel.text = "You don't have access to data yet. No need to request data from backend again."
            }
            
        }
        
        coordinator?.start()
        navigationController?.present(navController, animated: true, completion: nil)
    }
}

