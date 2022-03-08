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
    private var user: UserProfile?
    
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
                // Warning: Depending on result we need to update UI on main thread or Call another service on any thread
                
                switch result {
                case let .success(user):
                    self?.user = user
                    
                    if !user.isAllowedToViewLockedContent() {
                        self?.alertUserNotAllowedToViewContent()
                    } else if !user.hasCompletedUserProfile() {
                        self?.requestUserToCompleteProfile(with: user)
                    }
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
    
    private func alertUserNotAllowedToViewContent() {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                self.alertUserNotAllowedToViewContent()
            }
            return
        }
        
        let alert = UIAlertController(title: "Not Allowed", message: "You are not allowed to view content", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action)
        navigationController.present(alert, animated: true, completion: nil)
    }
}

/// Complete your profile flow
extension RootCoordinator : CompleteProfileFlowDelegate {
    private func requestUserToCompleteProfile(with user: UserProfile) {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                self.requestUserToCompleteProfile(with: user)
            }
            return
        }
        let vc = CompleteUserProfileComposer.compose(with: user)
        vc.flowDelegate = self
        
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func completeProfileSucceeded(with contactId: Int) {
        user?.contactId = contactId
        dismiss()
    }
    
    func completeYourProfileFailed() {
        dismiss()
    }
}

extension RootCoordinator {
    private func confirmEmailAndPhone() {
        
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

