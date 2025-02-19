//
//  ProfileViewModel.swift
//  WinnersViewModel
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import Foundation
import WinnersModel

public protocol IProfileViewModel {

}

public class ProfileViewModel: IProfileViewModel {

    private let profileService: IProfileService

    public init(profileService: IProfileService) {
        self.profileService = profileService
    }

}
