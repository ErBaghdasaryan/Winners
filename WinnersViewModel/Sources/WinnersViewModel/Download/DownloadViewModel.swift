//
//  DownloadViewModel.swift
//  WinnersViewModel
//
//  Created by Er Baghdasaryan on 20.02.25.
//

import Foundation
import WinnersModel

public protocol IDownloadViewModel {
    var imageName: String { get }
    func addImage(_ model: RecentModel)
}

public class DownloadViewModel: IDownloadViewModel {

    private let downloadService: IDownloadService
    public var imageName: String
    public var recentlies: [RecentModel] = []

    public init(downloadService: IDownloadService, navigationModel: DownloadNavigationModel) {
        self.downloadService = downloadService
        self.imageName = navigationModel.imageName
    }

    public func addImage(_ model: RecentModel) {
        do {
            _ = try self.downloadService.addImage(model)
        } catch {
            print(error)
        }
    }
}
