//
//  ViewController.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/6/22.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { set get }
    var navigationController: UINavigationController { set get }
    
    func start()
}

final class RootCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let loadViewController = sb.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        let service = LoadUserProfileService()
        
        loadViewController.load {
            service.get { [weak self] result in
                switch result {
                case let .success(_):
                    self?.dismiss()
                case .failure:
                    self?.dismiss()
                }
            }
        }
        
        navigationController.setViewControllers([loadViewController], animated: true)
    }
    
    private func dismiss() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.dismiss(animated: true, completion: nil)
        }
    }
}

class ViewController: UIViewController {
    var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction private func unlockButtonTapped() {
        let navController = UINavigationController()
        coordinator = RootCoordinator(navigationController: navController)
        
        coordinator?.start()
        navigationController?.present(navController, animated: true, completion: nil)
    }
}

