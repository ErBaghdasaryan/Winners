//
//  OnboardingRouter.swift
//  Winners
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import Foundation
import UIKit
import WinnersViewModel

final class OnboardingRouter: BaseRouter {
    static func showTabBarViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeTabBarViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }
}
