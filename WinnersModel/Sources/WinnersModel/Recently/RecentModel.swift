//
//  RecentModel.swift
//  WinnersModel
//
//  Created by Er Baghdasaryan on 21.02.25.
//

import UIKit

public struct RecentModel {
    public let id: Int?
    public let name: String

    public init(id: Int? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
