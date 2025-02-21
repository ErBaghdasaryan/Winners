//
//  HomeRouter.swift
//  Winners
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import Foundation
import UIKit
import WinnersViewModel
import WinnersModel

final class HomeRouter: BaseRouter {
    static func showDownloadViewController(in navigationController: UINavigationController,
                                           navigationModel: DownloadNavigationModel) {
        let viewController = ViewControllerFactory.makeDownloadViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = false
        navigationController.navigationBar.isHidden = false
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
