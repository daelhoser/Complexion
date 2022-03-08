//
//  ViewController.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/6/22.
//

import UIKit

class ViewController: UIViewController {
    var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction private func unlockButtonTapped() {
        let navController = UINavigationController()
        let listingAccessLevel = AccessLevel.twenty
        
        coordinator = RootCoordinator(navigationController: navController, listingAccessLevel: listingAccessLevel)
        
        coordinator?.start()
        navigationController?.present(navController, animated: true, completion: nil)
    }
}

