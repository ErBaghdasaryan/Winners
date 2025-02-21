//
//  ProfileViewModel.swift
//  WinnersViewModel
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import Foundation
import WinnersModel

public protocol IProfileViewModel {
    var recentlies: [RecentModel] { get set }
    func loadRecentlies()

}

public class ProfileViewModel: IProfileViewModel {

    private let profileService: IProfileService
    public var recentlies: [RecentModel] = []

    public init(profileService: IProfileService) {
        self.profileService = profileService
    }

    public func loadRecentlies() {
        do {
            self.recentlies = try self.profileService.getImages()
        } catch {
            print(error)
        }
    }
}
