//
//  OnboardingViewModel.swift
//  WinnersViewModel
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import Foundation
import WinnersModel

public protocol IOnboardingViewModel {

}

public class OnboardingViewModel: IOnboardingViewModel {

    private let onboardingService: IOnboardingService

    public init(onboardingService: IOnboardingService) {
        self.onboardingService = onboardingService
    }

}
