//
//  OnboardingAssembly.swift
//  Winners
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import Foundation
import WinnersViewModel
import Swinject
import SwinjectAutoregistration

final class OnboardingAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IOnboardingViewModel.self, initializer: OnboardingViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IOnboardingService.self, initializer: OnboardingService.init)
    }
}
