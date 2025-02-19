//
//  HomeService.swift
//  WinnersViewModel
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import UIKit
import WinnersModel

public protocol IHomeService {
    func getPopularItems() -> [HomePresentationModel]
    func getFirstHorizontalItems() -> [HomePresentationModel]
    func getSecondHorizontalItems() -> [HomePresentationModel]
}

public class HomeService: IHomeService {
    public init() { }

    public func getPopularItems() -> [HomePresentationModel] {
        [
            HomePresentationModel(image: "popular1"),
            HomePresentationModel(image: "popular2"),
            HomePresentationModel(image: "popular3"),
            HomePresentationModel(image: "popular4")
        ]
    }

    public func getFirstHorizontalItems() -> [HomePresentationModel] {
        [
            HomePresentationModel(image: "fH1"),
            HomePresentationModel(image: "fH2"),
            HomePresentationModel(image: "fH3"),
            HomePresentationModel(image: "fH4"),
            HomePresentationModel(image: "fH5"),
            HomePresentationModel(image: "fH6"),
            HomePresentationModel(image: "fH7"),
            HomePresentationModel(image: "fH8"),
            HomePresentationModel(image: "fH9")
        ]
    }

    public func getSecondHorizontalItems() -> [HomePresentationModel] {
        [
            HomePresentationModel(image: "sH1"),
            HomePresentationModel(image: "sH2"),
            HomePresentationModel(image: "sH3"),
            HomePresentationModel(image: "sH4"),
            HomePresentationModel(image: "sH5"),
            HomePresentationModel(image: "sH6"),
            HomePresentationModel(image: "sH7"),
            HomePresentationModel(image: "sH8"),
            HomePresentationModel(image: "sH9")
        ]
    }
}
