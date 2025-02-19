//
//  HomeViewModel.swift
//  WinnersViewModel
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import Foundation
import WinnersModel

public protocol IHomeViewModel {
    var popularItems: [HomePresentationModel] { get set }
    var firstHorizontalItems: [HomePresentationModel] { get set }
    var secondHorizontalItems: [HomePresentationModel] { get set }
    func loadItems()
}

public class HomeViewModel: IHomeViewModel {

    private let homeService: IHomeService

    public var popularItems: [HomePresentationModel] = []
    public var firstHorizontalItems: [HomePresentationModel] = []
    public var secondHorizontalItems: [HomePresentationModel] = []

    public init(homeService: IHomeService) {
        self.homeService = homeService
    }

    public func loadItems() {
        popularItems = homeService.getPopularItems()
        firstHorizontalItems = homeService.getFirstHorizontalItems()
        secondHorizontalItems = homeService.getSecondHorizontalItems()
    }

}
