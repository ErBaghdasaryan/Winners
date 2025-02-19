//
//  AppStorageService.swift
//  WinnersViewModel
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import Foundation

public protocol IAppStorageService {
    func saveData<T>(key: StorageKeys, value: T)
    func getData<T>(key: StorageKeys) -> T?
    func deleteData(key: StorageKeys)
    func hasData(for key: StorageKeys) -> Bool
}

public final class AppStorageService: IAppStorageService {

    private let userDefaults = UserDefaults.standard

    public init() { }

    public func saveData<T>(key: StorageKeys, value: T) {
        userDefaults.setValue(value, forKey: key.rawValue)
        userDefaults.synchronize()
    }

    public func getData<T>(key: StorageKeys) -> T? {
        return userDefaults.value(forKey: key.rawValue) as? T
    }

    public func deleteData(key: StorageKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
        userDefaults.synchronize()
    }

    public func hasData(for key: StorageKeys) -> Bool {
        return userDefaults.object(forKey: key.rawValue) != nil
    }
}

public enum StorageKeys: String {
    case skipOnboarding = "skipOnboarding"
    case isAlreadyOpened = "isAlreadyOpened"
    case alreadyOpened = "alreadyOpened"
    case apphudUserID = "ApphudUserID"
}
