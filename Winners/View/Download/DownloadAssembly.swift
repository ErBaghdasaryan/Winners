//
//  DownloadAssembly.swift
//  Winners
//
//  Created by Er Baghdasaryan on 20.02.25.
//

import Foundation
import WinnersViewModel
import WinnersModel
import Swinject
import SwinjectAutoregistration

final class DownloadAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IDownloadViewModel.self, argument: DownloadNavigationModel.self, initializer: DownloadViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IDownloadService.self, initializer: DownloadService.init)
    }
}
