//
//  BaseRouter.swift
//  Winners
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import UIKit
import Combine
import WinnersViewModel

class BaseRouter {

    class func popViewController(in navigationController: UINavigationController, completion: (() -> Void)? = nil) {
        completion?()
        navigationController.popViewController(animated: true)
    }
}
