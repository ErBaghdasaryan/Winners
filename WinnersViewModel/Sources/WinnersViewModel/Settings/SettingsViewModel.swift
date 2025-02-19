//
//  SettingsViewModel.swift
//  WinnersViewModel
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import Foundation
import WinnersModel

public protocol ISettingsViewModel {

}

public class SettingsViewModel: ISettingsViewModel {

    private let settingsService: ISettingsService

    public init(settingsService: ISettingsService) {
        self.settingsService = settingsService
    }

}
