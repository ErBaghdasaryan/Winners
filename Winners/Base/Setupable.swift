//
//  Setupable.swift
//  Winners
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import Foundation

protocol ISetupable {
    associatedtype SetupModel
    func setup(with model: SetupModel)
}
