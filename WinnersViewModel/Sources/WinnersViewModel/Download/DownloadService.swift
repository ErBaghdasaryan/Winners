//
//  DownloadService.swift
//  WinnersViewModel
//
//  Created by Er Baghdasaryan on 20.02.25.
//

import Foundation
import WinnersModel
import SQLite

public protocol IDownloadService {
    func addImage(_ model: RecentModel) throws -> RecentModel
}

public class DownloadService: IDownloadService {

    public init() { }

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    typealias Expression = SQLite.Expression

    public func addImage(_ model: RecentModel) throws -> RecentModel {
        let db = try Connection("\(path)/db.sqlite3")
        let images = Table("Images")
        let idColumn = Expression<Int>("id")
        let nameColumn = Expression<String>("name")

        try db.run(images.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(nameColumn)
        })

        let rowId = try db.run(images.insert(
            nameColumn <- model.name
        ))

        return RecentModel(id: Int(rowId),
                           name: model.name)
    }
}
