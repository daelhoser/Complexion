//
//  RootCoordinator.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { set get }
    var navigationController: UINavigationController { set get }
    
    func start()
}

final class RootCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    private var user: UserProfile?
    private let listingAccessLevel: AccessLevel
    var navigationController: UINavigationController
    
    var onCompletion: (() -> Void)?

    init(navigationController: UINavigationController, listingAccessLevel: AccessLevel) {
        self.navigationController = navigationController
        self.listingAccessLevel = listingAccessLevel
    }
    
    func start() {
        let loadViewController = createLoadingViewController()
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
    
    private func requestFailed(for viewController: UIViewController) {
        let title = "Error"
        let message = "Unable to complete request"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            viewController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(action)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    private func closeAndComplete() {
        navigationController.dismiss(animated: true) { [weak self] in
            self?.onCompletion?()
        }
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
    
    private func createLoadingViewController() -> LoadingViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        return sb.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
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
        user?.contactId = "\(contactId)"
        
        dismiss()
    }
    
    func completeYourProfileFailed() {
        dismiss()
    }
}

extension RootCoordinator : EmailAndPhoneVerificationStatusDelegate {
    private func confirmEmailAndPhone() {
        let childCoordinator = VerifyEmailAndPhoneFlowCoordinator(navigationController: navigationController)
        childCoordinator.completionDelegate = self
        
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }
    
    func completedSuccessfully() {
        removeVerificationCoordinator()

        getUserAccessLevel()
    }
    
    func cancelled() {
        removeVerificationCoordinator()
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func failed() {
        removeVerificationCoordinator()
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    private func removeVerificationCoordinator() {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator is VerifyEmailAndPhoneFlowCoordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

extension RootCoordinator {
    private func getUserAccessLevel() {
        let loadingViewController = createLoadingViewController()
        navigationController.setViewControllers([loadingViewController], animated: true)

        let service = UserAccessLevelService()
        
        loadingViewController.load {
            service.load(with: "any item id") { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case let .success(userAccessLevel):
                    self.user?.accessLevel = userAccessLevel
                    
                    if userAccessLevel == .twenty && self.listingAccessLevel == .thirty {
                        self.renderWaitingForApproval()
                    } else if userAccessLevel >= self.listingAccessLevel {
                        self.closeAndComplete()
                    } else {
                        self.getBypassStatus(with: loadingViewController)
                    }
                case .failure:
                    self.requestFailed(for: loadingViewController)
                }
            }
        }
    }
    
    private func renderWaitingForApproval() {
        
    }
    
    private func getBypassStatus(with vc: LoadingViewController) {
//        let getTransService =  CanBypassTransUnionForListingService()
//
//        vc.load {
//            return getTransService.load(listingId: model.listingId) { [weak self] result in
//                guard let self = self else { return }
//
//                switch result {
//                case let .success(response):
//                    if response.isVerified {
//                        self.logTransUnionUserVerified(for: vc)
//                    } else {
//                        self.checkIfUserHasCompletedTransUnion(for: vc)
//                    }
//                case .failure:
//                    self.requestFailed(for: vc)
//                }
//            }
//        }
    }
}
