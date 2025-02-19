//
//  ServiceAssembly.swift
//  Winners
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import WinnersViewModel

public final class ServiceAssembly: Assembly {

    public init() {}

    public func assemble(container: Container) {
        container.autoregister(IKeychainService.self, initializer: KeychainService.init)
        container.autoregister(IAppStorageService.self, initializer: AppStorageService.init)
    }
}
