//
//  SettingsRouter.swift
//  Winners
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import Foundation
import UIKit
import WinnersViewModel

final class SettingsRouter: BaseRouter {
    static func showPrivacyViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makePrivacyViewController()
        viewController.navigationItem.hidesBackButton = false
        navigationController.navigationBar.isHidden = false
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showTermsViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeTermsViewController()
        viewController.navigationItem.hidesBackButton = false
        navigationController.navigationBar.isHidden = false
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
